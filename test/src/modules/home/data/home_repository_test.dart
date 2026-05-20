import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/src/modules/core/connectivity/connectivity_service.dart';
import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_datasource.dart';
import 'package:rick_and_morty_api/src/modules/home/data/exceptions/home_exceptions.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/character_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/models/episode_model.dart';
import 'package:rick_and_morty_api/src/modules/home/data/repository/home_repository.dart';

import '../../../../helpers/home_fixtures.dart';

class _MockHomeDataSource extends Mock implements HomeLocalDataSource {}

class _MockConnectivityService extends Mock implements ConnectivityService {}

DioException _dioException(
  DioExceptionType type, {
  Object? error,
  int? statusCode,
}) {
  return DioException(
    requestOptions: RequestOptions(path: '/test'),
    type: type,
    error: error,
    response: statusCode == null
        ? null
        : Response(
            statusCode: statusCode,
            requestOptions: RequestOptions(path: '/test'),
          ),
  );
}

void main() {
  late HomeDataSource remote;
  late HomeLocalDataSource local;
  late ConnectivityService connectivity;
  late HomeRepositoryImpl repository;
  late EpisodeModel episode;
  late CharacterModel character;

  setUp(() {
    remote = _MockHomeDataSource();
    local = _MockHomeDataSource();
    connectivity = _MockConnectivityService();
    repository = HomeRepositoryImpl(remote, local, connectivity);
    episode = episodeModel();
    character = characterModel();
  });

  group('HomeRepositoryImpl', () {
    test(
      'getEpisode online busca remoto, salva local e retorna remoto',
      () async {
        when(() => connectivity.hasConnection).thenAnswer((_) async => true);
        when(() => remote.getEpisode(28)).thenAnswer((_) async => episode);
        when(() => local.saveEpisode(episode)).thenAnswer((_) async {});

        final result = await repository.getEpisode(28);

        expect(result, same(episode));
        verify(() => remote.getEpisode(28)).called(1);
        verify(() => local.saveEpisode(episode)).called(1);
      },
    );

    test('getEpisode offline retorna cache local sem chamar remoto', () async {
      when(() => connectivity.hasConnection).thenAnswer((_) async => false);
      when(() => local.getEpisodeById(28)).thenAnswer((_) async => episode);

      final result = await repository.getEpisode(28);

      expect(result, same(episode));
      verifyNever(() => remote.getEpisode(any()));
    });

    test(
      'getEpisode offline sem cache lança HomeOfflineCacheException',
      () async {
        when(() => connectivity.hasConnection).thenAnswer((_) async => false);
        when(() => local.getEpisodeById(28)).thenAnswer((_) async => null);

        await expectLater(
          () => repository.getEpisode(28),
          throwsA(isA<HomeOfflineCacheException>()),
        );
      },
    );

    test('getEpisode usa cache quando erro remoto parece rede', () async {
      when(() => connectivity.hasConnection).thenAnswer((_) async => true);
      when(
        () => remote.getEpisode(28),
      ).thenThrow(_dioException(DioExceptionType.connectionTimeout));
      when(() => local.getEpisodeById(28)).thenAnswer((_) async => episode);

      final result = await repository.getEpisode(28);

      expect(result, same(episode));
    });

    test(
      'getEpisode usa cache quando DioException unknown contém SocketException',
      () async {
        when(() => connectivity.hasConnection).thenAnswer((_) async => true);
        when(() => remote.getEpisode(28)).thenThrow(
          _dioException(
            DioExceptionType.unknown,
            error: const SocketException('network'),
          ),
        );
        when(() => local.getEpisodeById(28)).thenAnswer((_) async => episode);

        final result = await repository.getEpisode(28);

        expect(result, same(episode));
      },
    );

    test('getEpisode converte 404 em HomeEpisodeNotFoundException', () async {
      when(() => connectivity.hasConnection).thenAnswer((_) async => true);
      when(
        () => remote.getEpisode(28),
      ).thenThrow(_dioException(DioExceptionType.badResponse, statusCode: 404));

      await expectLater(
        () => repository.getEpisode(28),
        throwsA(isA<HomeEpisodeNotFoundException>()),
      );
    });

    test('getEpisode converte 500 em HomeServerException', () async {
      when(() => connectivity.hasConnection).thenAnswer((_) async => true);
      when(
        () => remote.getEpisode(28),
      ).thenThrow(_dioException(DioExceptionType.badResponse, statusCode: 500));

      await expectLater(
        () => repository.getEpisode(28),
        throwsA(
          isA<HomeServerException>().having(
            (error) => error.statusCode,
            'statusCode',
            500,
          ),
        ),
      );
    });

    test('getCharacter offline retorna personagem em cache', () async {
      when(() => connectivity.hasConnection).thenAnswer((_) async => false);
      when(() => local.getCharacterById(1)).thenAnswer((_) async => character);

      final result = await repository.getCharacter(1);

      expect(result, same(character));
      verifyNever(() => remote.getCharacter(any()));
    });

    test(
      'getCharactersByIds retorna vazio sem consultar dependências',
      () async {
        final result = await repository.getCharactersByIds([]);

        expect(result, isEmpty);
        verifyNever(() => connectivity.hasConnection);
        verifyNever(() => remote.getCharactersByIds(any()));
      },
    );

    test(
      'getCharactersByIds online busca remoto, salva local e retorna remoto',
      () async {
        final characters = [
          character,
          characterModel(id: 2, name: 'Morty Smith'),
        ];
        when(() => connectivity.hasConnection).thenAnswer((_) async => true);
        when(
          () => remote.getCharactersByIds(any(that: equals([1, 2]))),
        ).thenAnswer((_) async => characters);
        when(() => local.saveCharacters(characters)).thenAnswer((_) async {});

        final result = await repository.getCharactersByIds([1, 2]);

        expect(result, same(characters));
        verify(() => local.saveCharacters(characters)).called(1);
      },
    );

    test('getCharactersByIds offline retorna cache local ordenado', () async {
      final characters = [characterModel(id: 2), characterModel(id: 1)];
      when(() => connectivity.hasConnection).thenAnswer((_) async => false);
      when(
        () => local.getCharactersByIdsOrdered(any(that: equals([2, 1]))),
      ).thenAnswer((_) async => characters);

      final result = await repository.getCharactersByIds([2, 1]);

      expect(result, same(characters));
      verifyNever(() => remote.getCharactersByIds(any()));
    });

    test(
      'getCharactersByIds usa cache quando erro remoto parece rede',
      () async {
        final characters = [character];
        when(() => connectivity.hasConnection).thenAnswer((_) async => true);
        when(
          () => remote.getCharactersByIds(any(that: equals([1]))),
        ).thenThrow(_dioException(DioExceptionType.connectionError));
        when(
          () => local.getCharactersByIdsOrdered(any(that: equals([1]))),
        ).thenAnswer((_) async => characters);

        final result = await repository.getCharactersByIds([1]);

        expect(result, same(characters));
      },
    );
  });
}
