import 'dart:io';

import 'package:dio/dio.dart';

abstract class HomeException implements Exception {
  HomeException(this.message, this.userMessage, {this.statusCode});

  final String message;
  final String userMessage;
  final int? statusCode;

  @override
  String toString() => message;
}

class HomeNetworkException extends HomeException {
  HomeNetworkException()
    : super('Network connection error', 'Sem conexão com a internet.');
}

class HomeTimeoutException extends HomeException {
  HomeTimeoutException()
    : super('Request timeout', 'Tempo de conexão esgotado.');
}

class HomeServerException extends HomeException {
  HomeServerException(int? statusCode)
    : super(
        'Server error: ${statusCode ?? 'unknown'}',
        'Erro no servidor (${statusCode ?? 'desconhecido'}).',
        statusCode: statusCode,
      );
}

class HomeEpisodeNotFoundException extends HomeException {
  HomeEpisodeNotFoundException()
    : super('Episode not found', 'Episódio não encontrado.', statusCode: 404);
}

class HomeUnauthorizedException extends HomeException {
  HomeUnauthorizedException()
    : super(
        'Unauthorized access',
        'Você não tem permissão para esta operação.',
        statusCode: 401,
      );
}

class HomeForbiddenException extends HomeException {
  HomeForbiddenException()
    : super(
        'Forbidden access',
        'Acesso negado. Você não tem permissão para esta operação.',
        statusCode: 403,
      );
}

class HomeBadRequestException extends HomeException {
  HomeBadRequestException(String details)
    : super(
        'Bad request: $details',
        'Dados inválidos. Verifique as informações e tente novamente.',
        statusCode: 400,
      );
}

class HomeConflictException extends HomeException {
  HomeConflictException()
    : super(
        'Conflict error',
        'Conflito com dados existentes. Atualize e tente novamente.',
        statusCode: 409,
      );
}

class HomeDataException extends HomeException {
  HomeDataException(String details)
    : super(
        'Data parsing error: $details',
        'Erro ao processar dados. Tente novamente.',
      );
}

class HomeValidationException extends HomeException {
  HomeValidationException(String details)
    : super(
        'Validation error: $details',
        'Dados inválidos. Verifique as informações e tente novamente.',
      );
}

class HomeOfflineCacheException extends HomeException {
  HomeOfflineCacheException(String userMessage)
    : super('Offline cache error', userMessage);
}

class HomeUnknownException extends HomeException {
  HomeUnknownException(String details)
    : super('Unknown error: $details', 'Erro inesperado. Tente novamente.');
}

HomeException mapDioExceptionToHomeException(DioException exception) {
  switch (exception.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return HomeTimeoutException();
    case DioExceptionType.connectionError:
      return HomeNetworkException();
    case DioExceptionType.badResponse:
      return _mapStatusCode(exception.response?.statusCode, exception.message);
    case DioExceptionType.unknown:
      if (exception.error is SocketException) return HomeNetworkException();
      return HomeUnknownException(exception.message ?? exception.toString());
    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
      return HomeUnknownException(exception.message ?? exception.toString());
  }
}

HomeException _mapStatusCode(int? statusCode, String? details) {
  switch (statusCode) {
    case 400:
      return HomeBadRequestException(details ?? 'invalid request');
    case 401:
      return HomeUnauthorizedException();
    case 403:
      return HomeForbiddenException();
    case 404:
      return HomeEpisodeNotFoundException();
    case 409:
      return HomeConflictException();
    default:
      return HomeServerException(statusCode);
  }
}
