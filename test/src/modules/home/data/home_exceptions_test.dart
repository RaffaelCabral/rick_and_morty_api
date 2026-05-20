import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_api/src/modules/home/data/exceptions/home_exceptions.dart';

DioException _dioException(
  DioExceptionType type, {
  Object? error,
  int? statusCode,
  String? message,
}) {
  return DioException(
    requestOptions: RequestOptions(path: '/test'),
    type: type,
    error: error,
    message: message,
    response: statusCode == null
        ? null
        : Response(
            statusCode: statusCode,
            requestOptions: RequestOptions(path: '/test'),
          ),
  );
}

void main() {
  group('mapDioExceptionToHomeException', () {
    test('mapeia timeouts para HomeTimeoutException', () {
      expect(
        mapDioExceptionToHomeException(
          _dioException(DioExceptionType.connectionTimeout),
        ),
        isA<HomeTimeoutException>(),
      );
      expect(
        mapDioExceptionToHomeException(
          _dioException(DioExceptionType.receiveTimeout),
        ).userMessage,
        'Tempo de conexão esgotado.',
      );
    });

    test('mapeia connectionError para HomeNetworkException', () {
      final exception = mapDioExceptionToHomeException(
        _dioException(DioExceptionType.connectionError),
      );

      expect(exception, isA<HomeNetworkException>());
      expect(exception.userMessage, 'Sem conexão com a internet.');
    });

    test('mapeia unknown com SocketException para HomeNetworkException', () {
      final exception = mapDioExceptionToHomeException(
        _dioException(
          DioExceptionType.unknown,
          error: const SocketException('network'),
        ),
      );

      expect(exception, isA<HomeNetworkException>());
    });

    test('mapeia status codes conhecidos', () {
      expect(
        mapDioExceptionToHomeException(
          _dioException(DioExceptionType.badResponse, statusCode: 400),
        ),
        isA<HomeBadRequestException>(),
      );
      expect(
        mapDioExceptionToHomeException(
          _dioException(DioExceptionType.badResponse, statusCode: 401),
        ),
        isA<HomeUnauthorizedException>(),
      );
      expect(
        mapDioExceptionToHomeException(
          _dioException(DioExceptionType.badResponse, statusCode: 403),
        ),
        isA<HomeForbiddenException>(),
      );
      expect(
        mapDioExceptionToHomeException(
          _dioException(DioExceptionType.badResponse, statusCode: 404),
        ),
        isA<HomeEpisodeNotFoundException>(),
      );
      expect(
        mapDioExceptionToHomeException(
          _dioException(DioExceptionType.badResponse, statusCode: 409),
        ),
        isA<HomeConflictException>(),
      );
    });

    test('mapeia status desconhecido para HomeServerException', () {
      final exception = mapDioExceptionToHomeException(
        _dioException(DioExceptionType.badResponse, statusCode: 500),
      );

      expect(exception, isA<HomeServerException>());
      expect(exception.statusCode, 500);
      expect(exception.userMessage, 'Erro no servidor (500).');
    });

    test('mapeia erro desconhecido para HomeUnknownException', () {
      final exception = mapDioExceptionToHomeException(
        _dioException(DioExceptionType.unknown, message: 'boom'),
      );

      expect(exception, isA<HomeUnknownException>());
      expect(exception.userMessage, 'Erro inesperado. Tente novamente.');
    });
  });
}
