import 'dart:math';

import 'package:dio/dio.dart';
import 'package:rick_and_morty_api/src/modules/core/http_service/dio_service.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/character_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/episode_model.dart';

abstract class HomeRemoteDatasource {
  Future<EpisodeModel> getEpisode(int id);
  Future<CharacterModel> getCharacter(int id);
  Future<List<CharacterModel>> getCharactersByIds(List<int> ids);
}

int extractCharacterIdFromUrl(String url) {
  final match = RegExp(r'/character/(\d+)$').firstMatch(url);
  if (match == null) {
    throw FormatException('URL de personagem inválida: $url');
  }
  return int.parse(match.group(1)!);
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  HomeRemoteDatasourceImpl(this._http);

  final HttpService _http;

  @override
  Future<EpisodeModel> getEpisode(int id) async {
    final response = await _http.get<Map<String, dynamic>>('/episode/$id');
    final data = response.data;

    if (data == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Resposta vazia ao buscar episódio $id',
      );
    }

    return EpisodeModel.fromMap(data);
  }

  @override
  Future<CharacterModel> getCharacter(int id) async {
    final response = await _http.get<Map<String, dynamic>>('/character/$id');
    final data = response.data;

    if (data == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        message: 'Resposta vazia ao buscar personagem $id',
      );
    }

    return CharacterModel.fromMap(data);
  }

  static const int _characterBatchSize = 20;

  @override
  Future<List<CharacterModel>> getCharactersByIds(List<int> ids) async {
    if (ids.isEmpty) return [];

    final characters = <CharacterModel>[];

    for (var i = 0; i < ids.length; i += _characterBatchSize) {
      final end = min(i + _characterBatchSize, ids.length);
      final chunk = ids.sublist(i, end);
      final path = '/character/${chunk.join(',')}';

      final response = await _http.get<dynamic>(path);
      final data = response.data;

      if (data == null) {
        throw DioException(
          requestOptions: response.requestOptions,
          message: 'Resposta vazia ao buscar personagens',
        );
      }

      characters.addAll(_parseCharactersResponse(data));
    }

    return characters;
  }

  List<CharacterModel> _parseCharactersResponse(dynamic data) {
    if (data is List) {
      return data
          .map((e) => CharacterModel.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    if (data is Map<String, dynamic>) {
      return [CharacterModel.fromMap(data)];
    }
    throw FormatException('Formato de resposta de personagens inesperado');
  }
}
