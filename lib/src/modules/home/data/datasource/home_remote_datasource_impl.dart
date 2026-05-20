import 'dart:math';

import 'package:rick_and_morty_api/src/modules/core/http_service/dio_service.dart';
import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_datasource.dart';
import 'package:rick_and_morty_api/src/modules/home/data/exceptions/home_exceptions.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/character_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/episode_model.dart';

class HomeRemoteDataSourceImpl implements HomeDataSource {
  HomeRemoteDataSourceImpl(this._http);

  final HttpService _http;

  @override
  Future<EpisodeModel> getEpisode(int id) async {
    final response = await _http.get<Map<String, dynamic>>('/episode/$id');
    final data = response.data;

    if (data == null) {
      throw HomeDataException('Resposta vazia ao buscar episódio $id');
    }

    return EpisodeModel.fromMap(data);
  }

  @override
  Future<CharacterModel> getCharacter(int id) async {
    final response = await _http.get<Map<String, dynamic>>('/character/$id');
    final data = response.data;

    if (data == null) {
      throw HomeDataException('Resposta vazia ao buscar personagem $id');
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
        throw HomeDataException('Resposta vazia ao buscar personagens');
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
    throw HomeDataException('Formato de resposta de personagens inesperado');
  }
}
