import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_datasource.dart';
import 'package:rick_and_morty_api/src/modules/home/data/local/home_local_datasource.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/character_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/episode_model.dart';

abstract class HomeRepository {
  Future<EpisodeModel> getEpisode(int id);
  Future<CharacterModel> getCharacter(int id);
  Future<List<CharacterModel>> getCharactersByIds(List<int> ids);
}

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._remoteDatasource, this._localDatasource);

  final HomeRemoteDatasource _remoteDatasource;
  final HomeLocalDatasource _localDatasource;

  @override
  Future<EpisodeModel> getEpisode(int id) async {
    try {
      final episode = await _remoteDatasource.getEpisode(id);
      await _localDatasource.saveEpisode(episode);
      return episode;
    } on DioException catch (e) {
      if (_isLikelyNetworkIssue(e)) {
        final cached = await _localDatasource.getEpisodeById(id);
        if (cached != null) return cached;
      }
      rethrow;
    }
  }

  @override
  Future<CharacterModel> getCharacter(int id) async {
    try {
      final character = await _remoteDatasource.getCharacter(id);
      await _localDatasource.saveCharacters([character]);
      return character;
    } on DioException catch (e) {
      if (_isLikelyNetworkIssue(e)) {
        final cached = await _localDatasource.getCharacterById(id);
        if (cached != null) return cached;
      }
      rethrow;
    }
  }

  @override
  Future<List<CharacterModel>> getCharactersByIds(List<int> ids) async {
    if (ids.isEmpty) return [];

    try {
      final list = await _remoteDatasource.getCharactersByIds(ids);
      await _localDatasource.saveCharacters(list);
      return list;
    } on DioException catch (e) {
      if (_isLikelyNetworkIssue(e)) {
        return _localDatasource.getCharactersByIdsOrdered(ids);
      }
      rethrow;
    }
  }

  static bool _isLikelyNetworkIssue(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.unknown:
        return e.error is SocketException;
      default:
        return false;
    }
  }
}
