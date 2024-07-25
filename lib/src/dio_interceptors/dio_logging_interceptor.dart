import 'dart:async';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';

/// A Dio interceptor that logs detailed information about HTTP
/// requests and responses.
class DioLoggingInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final startTime = DateTime.now();
    options.extra['startTime'] = startTime;
    developer.log(
      '''
[REQUEST]
Method: ${options.method}
URL: ${options.uri}
Headers: ${options.headers}
Body: ${options.data}
Time: $startTime
''',
    );
    return handler.next(options); // continue
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    final startTime = response.requestOptions.extra['startTime'] as DateTime?;
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime ?? endTime);
    developer.log(
      '''
[RESPONSE]
Method: ${response.requestOptions.method}
URL: ${response.requestOptions.uri}
Status Code: ${response.statusCode}
Headers: ${response.headers}
Body: ${response.data}
Duration: ${duration.inMilliseconds}ms
Time: $endTime
''',
    );
    return handler.next(response); // continue
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final startTime = err.requestOptions.extra['startTime'] as DateTime?;
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime ?? endTime);
    developer.log(
      '''
[ERROR]
Method: ${err.requestOptions.method}
URL: ${err.requestOptions.uri}
Status Code: ${err.response?.statusCode}
Headers: ${err.response?.headers}
Error: ${err.error}
Response: ${err.response?.data}
Duration: ${duration.inMilliseconds}ms
Time: $endTime
''',
    );
    return handler.next(err);
  }
}
