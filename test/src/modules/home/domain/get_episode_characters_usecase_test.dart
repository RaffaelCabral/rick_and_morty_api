import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_datasource.dart';
import 'package:rick_and_morty_api/src/modules/home/data/repository/home_repository.dart';
import 'package:rick_and_morty_api/src/modules/home/domain/usecase/get_episode_characters_usecase.dart';

import '../../../../helpers/home_fixtures.dart';

class _MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late HomeRepository repository;
  late GetEpisodeCharactersUseCase usecase;

  setUp(() {
    repository = _MockHomeRepository();
    usecase = GetEpisodeCharactersUseCase(repository);
  });

  group('GetEpisodeCharactersUseCase', () {
    test('lança ArgumentError quando entrada está vazia', () async {
      await expectLater(
        () => usecase(''),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            'Informe o número do episódio.',
          ),
        ),
      );
    });

    test('lança ArgumentError quando entrada não é numérica', () async {
      await expectLater(
        () => usecase('abc'),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            'Número de episódio inválido.',
          ),
        ),
      );
    });

    test('lança ArgumentError quando entrada é zero ou negativa', () async {
      await expectLater(
        () => usecase('0'),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            'Informe um número de episódio válido.',
          ),
        ),
      );

      await expectLater(
        () => usecase('-1'),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            'Informe um número de episódio válido.',
          ),
        ),
      );
    });

    test(
      'aceita entrada com espaços e busca personagens do episódio',
      () async {
        final episode = episodeModel(
          characters: [
            'https://rickandmortyapi.com/api/character/1',
            'https://rickandmortyapi.com/api/character/2',
          ],
        );
        final characters = [
          characterModel(id: 2, name: 'Morty Smith'),
          characterModel(id: 1, name: 'Rick Sanchez'),
        ];

        when(() => repository.getEpisode(28)).thenAnswer((_) async => episode);
        when(
          () => repository.getCharactersByIds([1, 2]),
        ).thenAnswer((_) async => characters);

        final result = await usecase(' 28 ');

        expect(result.episode, same(episode));
        expect(result.characters.map((character) => character.name), [
          'Morty Smith',
          'Rick Sanchez',
        ]);
        verify(() => repository.getEpisode(28)).called(1);
        verify(() => repository.getCharactersByIds([1, 2])).called(1);
      },
    );

    test('retorna personagens ordenados por nome ignorando caixa', () async {
      final episode = episodeModel(
        characters: [
          'https://rickandmortyapi.com/api/character/1',
          'https://rickandmortyapi.com/api/character/2',
          'https://rickandmortyapi.com/api/character/3',
        ],
      );
      final characters = [
        characterModel(id: 1, name: 'rick Sanchez'),
        characterModel(id: 2, name: 'Beth Smith'),
        characterModel(id: 3, name: 'morty Smith'),
      ];

      when(() => repository.getEpisode(28)).thenAnswer((_) async => episode);
      when(
        () => repository.getCharactersByIds([1, 2, 3]),
      ).thenAnswer((_) async => characters);

      final result = await usecase('28');

      expect(result.characters.map((character) => character.name), [
        'Beth Smith',
        'morty Smith',
        'rick Sanchez',
      ]);
    });
  });

  group('extractCharacterIdFromUrl', () {
    test('extrai ID do fim da URL', () {
      expect(
        extractCharacterIdFromUrl(
          'https://rickandmortyapi.com/api/character/42',
        ),
        42,
      );
    });

    test('lança FormatException para URL inválida', () {
      expect(
        () => extractCharacterIdFromUrl(
          'https://rickandmortyapi.com/api/character/rick',
        ),
        throwsFormatException,
      );
    });
  });
}
