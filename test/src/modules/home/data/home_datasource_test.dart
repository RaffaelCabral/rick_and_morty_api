import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_api/src/modules/core/http_service/dio_service.dart';
import 'package:rick_and_morty_api/src/modules/home/data/exceptions/home_exceptions.dart';
import 'package:rick_and_morty_api/src/modules/home/data/datasource/home_remote_datasource_impl.dart';

import '../../../../helpers/home_fixtures.dart';

class _MockHttpService extends Mock implements HttpService {}

Response<T> _response<T>(T? data, String path) {
  return Response<T>(
    data: data,
    requestOptions: RequestOptions(path: path),
  );
}

void main() {
  late HttpService http;
  late HomeRemoteDataSourceImpl datasource;

  setUp(() {
    http = _MockHttpService();
    datasource = HomeRemoteDataSourceImpl(http);
  });

  group('HomeRemoteDataSourceImpl', () {
    test('getEpisode chama endpoint e converte resposta válida', () async {
      when(
        () => http.get<Map<String, dynamic>>('/episode/28'),
      ).thenAnswer((_) async => _response(episodeMap(), '/episode/28'));

      final episode = await datasource.getEpisode(28);

      expect(episode.id, 28);
      expect(episode.name, 'The Ricklantis Mixup');
      verify(() => http.get<Map<String, dynamic>>('/episode/28')).called(1);
    });

    test('getEpisode lança HomeDataException quando resposta é nula', () async {
      when(
        () => http.get<Map<String, dynamic>>('/episode/28'),
      ).thenAnswer((_) async => _response(null, '/episode/28'));

      await expectLater(
        () => datasource.getEpisode(28),
        throwsA(isA<HomeDataException>()),
      );
    });

    test('getCharacter chama endpoint e converte resposta válida', () async {
      when(
        () => http.get<Map<String, dynamic>>('/character/1'),
      ).thenAnswer((_) async => _response(characterMap(), '/character/1'));

      final character = await datasource.getCharacter(1);

      expect(character.id, 1);
      expect(character.name, 'Rick Sanchez');
      verify(() => http.get<Map<String, dynamic>>('/character/1')).called(1);
    });

    test(
      'getCharacter lança HomeDataException quando resposta é nula',
      () async {
        when(
          () => http.get<Map<String, dynamic>>('/character/1'),
        ).thenAnswer((_) async => _response(null, '/character/1'));

        await expectLater(
          () => datasource.getCharacter(1),
          throwsA(isA<HomeDataException>()),
        );
      },
    );

    test('getCharactersByIds retorna lista para resposta em array', () async {
      when(() => http.get<dynamic>('/character/1,2')).thenAnswer(
        (_) async => _response([
          characterMap(id: 1),
          characterMap(id: 2, name: 'Morty Smith'),
        ], '/character/1,2'),
      );

      final characters = await datasource.getCharactersByIds([1, 2]);

      expect(characters.map((character) => character.id), [1, 2]);
    });

    test(
      'getCharactersByIds retorna lista para resposta em objeto único',
      () async {
        when(
          () => http.get<dynamic>('/character/1'),
        ).thenAnswer((_) async => _response(characterMap(), '/character/1'));

        final characters = await datasource.getCharactersByIds([1]);

        expect(characters, hasLength(1));
        expect(characters.single.name, 'Rick Sanchez');
      },
    );

    test('getCharactersByIds divide chamadas em lotes de 20 IDs', () async {
      final ids = List<int>.generate(45, (index) => index + 1);

      when(() => http.get<dynamic>(any())).thenAnswer((invocation) async {
        final path = invocation.positionalArguments.first as String;
        final chunkIds = path
            .replaceFirst('/character/', '')
            .split(',')
            .map(int.parse)
            .toList();
        return _response(
          chunkIds
              .map((id) => characterMap(id: id, name: 'Character $id'))
              .toList(),
          path,
        );
      });

      final characters = await datasource.getCharactersByIds(ids);

      expect(characters, hasLength(45));
      verify(
        () => http.get<dynamic>(
          '/character/1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20',
        ),
      ).called(1);
      verify(
        () => http.get<dynamic>(
          '/character/21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40',
        ),
      ).called(1);
      verify(() => http.get<dynamic>('/character/41,42,43,44,45')).called(1);
    });

    test('getCharactersByIds retorna vazio para lista vazia', () async {
      final characters = await datasource.getCharactersByIds([]);

      expect(characters, isEmpty);
      verifyNever(() => http.get<dynamic>(any()));
    });

    test(
      'getCharactersByIds lança HomeDataException quando resposta é nula',
      () async {
        when(
          () => http.get<dynamic>('/character/1'),
        ).thenAnswer((_) async => _response(null, '/character/1'));

        await expectLater(
          () => datasource.getCharactersByIds([1]),
          throwsA(isA<HomeDataException>()),
        );
      },
    );

    test(
      'getCharactersByIds lança HomeDataException para formato inesperado',
      () async {
        when(
          () => http.get<dynamic>('/character/1'),
        ).thenAnswer((_) async => _response('invalid', '/character/1'));

        await expectLater(
          () => datasource.getCharactersByIds([1]),
          throwsA(isA<HomeDataException>()),
        );
      },
    );
  });
}
