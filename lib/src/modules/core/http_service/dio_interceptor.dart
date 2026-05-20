import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '[HTTP] → ${options.method} ${options.uri}\n'
        'Headers: ${options.headers}\n'
        'Query: ${options.queryParameters}\n'
        'Body: ${options.data}',
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '[HTTP] ← ${response.statusCode} ${response.requestOptions.uri}\n'
        'Data: ${response.data}',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '[HTTP] ✕ ${err.requestOptions.method} ${err.requestOptions.uri}\n'
        'Type: ${err.type}\n'
        'Message: ${err.message}\n'
        'Status: ${err.response?.statusCode}\n'
        'Data: ${err.response?.data}',
      );
    }
    handler.next(err);
  }
}
