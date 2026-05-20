import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_local_datasource_impl.dart';
import 'package:rick_and_morty_api/src/modules/home/data/exceptions/home_exceptions.dart';
import 'package:rick_and_morty_api/src/modules/home/data/local/home_cache_database.dart';

import '../../../../helpers/home_fixtures.dart';

void main() {
  late HomeCacheDatabase database;
  late HomeLocalDataSourceImpl datasource;

  setUp(() {
    database = HomeCacheDatabase(NativeDatabase.memory());
    datasource = HomeLocalDataSourceImpl(database);
  });

  tearDown(() async {
    await database.close();
  });

  group('HomeLocalDataSourceImpl', () {
    test('saveEpisode persiste e getEpisodeById retorna episódio', () async {
      final episode = episodeModel();

      await datasource.saveEpisode(episode);
      final cached = await datasource.getEpisodeById(episode.id);

      expect(cached, isNotNull);
      expect(cached!.id, episode.id);
      expect(cached.name, episode.name);
      expect(cached.characters, episode.characters);
      expect(cached.created, isA<DateTime>());
    });

    test('saveEpisode atualiza registro existente pelo mesmo ID', () async {
      await datasource.saveEpisode(episodeModel(id: 28, name: 'Old'));
      await datasource.saveEpisode(episodeModel(id: 28, name: 'New'));

      final cached = await datasource.getEpisodeById(28);

      expect(cached!.name, 'New');
    });

    test(
      'saveCharacters persiste lista e getCharacterById retorna personagem',
      () async {
        final characters = [
          characterModel(id: 1),
          characterModel(id: 2, name: 'Morty Smith'),
        ];

        await datasource.saveCharacters(characters);
        final cached = await datasource.getCharacterById(2);

        expect(cached, isNotNull);
        expect(cached!.id, 2);
        expect(cached.name, 'Morty Smith');
        expect(cached.origin.name, characters[1].origin.name);
        expect(cached.episode, characters[1].episode);
      },
    );

    test('saveCharacters com lista vazia não quebra', () async {
      await datasource.saveCharacters([]);

      final cached = await datasource.getCharacterById(1);

      expect(cached, isNull);
    });

    test(
      'getCharactersByIdsOrdered retorna na ordem dos IDs pedidos',
      () async {
        await datasource.saveCharacters([
          characterModel(id: 1, name: 'Rick Sanchez'),
          characterModel(id: 2, name: 'Morty Smith'),
          characterModel(id: 3, name: 'Beth Smith'),
        ]);

        final cached = await datasource.getCharactersByIdsOrdered([3, 1, 2]);

        expect(cached.map((character) => character.id), [3, 1, 2]);
      },
    );

    test(
      'getCharactersByIdsOrdered lança quando faltar algum personagem',
      () async {
        await datasource.saveCharacters([characterModel(id: 1)]);

        await expectLater(
          () => datasource.getCharactersByIdsOrdered([1, 2]),
          throwsA(isA<HomeOfflineCacheException>()),
        );
      },
    );
  });
}
