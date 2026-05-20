import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rick_and_morty_api/src/modules/core/connectivity/connectivity_service.dart';
import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_datasource.dart';
import 'package:rick_and_morty_api/src/modules/home/data/exceptions/home_exceptions.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/character_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/episode_model.dart';

abstract class HomeRepository {
  Future<EpisodeModel> getEpisode(int id);
  Future<CharacterModel> getCharacter(int id);
  Future<List<CharacterModel>> getCharactersByIds(List<int> ids);
}

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._connectivityService,
  );

  final HomeDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;
  final ConnectivityService _connectivityService;

  static const String _episodeNotCachedMessage =
      'Ainda não temos dados salvos para esse episódio. '
      'Conecte-se à internet e busque esse episódio uma vez para poder acessá-lo offline.';

  @override
  Future<EpisodeModel> getEpisode(int id) async {
    if (!await _connectivityService.hasConnection) {
      return _getCachedEpisodeOrThrow(id);
    }

    try {
      final episode = await _remoteDataSource.getEpisode(id);
      await _localDataSource.saveEpisode(episode);
      return episode;
    } on DioException catch (e) {
      if (_isLikelyNetworkIssue(e)) {
        return _getCachedEpisodeOrThrow(id);
      }
      throw mapDioExceptionToHomeException(e);
    }
  }

  @override
  Future<CharacterModel> getCharacter(int id) async {
    if (!await _connectivityService.hasConnection) {
      return _getCachedCharacterOrThrow(id);
    }

    try {
      final character = await _remoteDataSource.getCharacter(id);
      await _localDataSource.saveCharacters([character]);
      return character;
    } on DioException catch (e) {
      if (_isLikelyNetworkIssue(e)) {
        return _getCachedCharacterOrThrow(id);
      }
      throw mapDioExceptionToHomeException(e);
    }
  }

  @override
  Future<List<CharacterModel>> getCharactersByIds(List<int> ids) async {
    if (ids.isEmpty) return [];

    if (!await _connectivityService.hasConnection) {
      return _localDataSource.getCharactersByIdsOrdered(ids);
    }

    try {
      final list = await _remoteDataSource.getCharactersByIds(ids);
      await _localDataSource.saveCharacters(list);
      return list;
    } on DioException catch (e) {
      if (_isLikelyNetworkIssue(e)) {
        return _localDataSource.getCharactersByIdsOrdered(ids);
      }
      throw mapDioExceptionToHomeException(e);
    }
  }

  Future<EpisodeModel> _getCachedEpisodeOrThrow(int id) async {
    final cached = await _localDataSource.getEpisodeById(id);
    if (cached != null) return cached;
    throw HomeOfflineCacheException(_episodeNotCachedMessage);
  }

  Future<CharacterModel> _getCachedCharacterOrThrow(int id) async {
    final cached = await _localDataSource.getCharacterById(id);
    if (cached != null) return cached;
    throw HomeOfflineCacheException(
      'Ainda não temos dados salvos para esse personagem. '
      'Conecte-se à internet e busque esse personagem uma vez para poder acessá-lo offline.',
    );
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
