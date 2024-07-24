import 'dart:async';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;
import 'package:http_interceptor/models/interceptor_contract.dart';

/// A class that intercepts HTTP requests and responses for logging purposes.
class HttpLoggingInterceptor extends InterceptorContract {
  @override
  FutureOr<http.BaseRequest> interceptRequest({
    required http.BaseRequest request,
  }) async {
    developer.log(
      '''
Method: ${request.method}
URL: ${request.url}
Headers: ${request.headers}
Body: ${_requestBody(request)}
''',
      name: 'REQUEST',
    );

    return request;
  }

  @override
  FutureOr<http.BaseResponse> interceptResponse({
    required http.BaseResponse response,
  }) async {
    developer.log(
      '''
Method: ${response.request?.method}
URL: ${response.request?.url}
Status Code: ${response.statusCode}
Headers: ${response.headers}
Body: ${_responseBody(response)}
''',
      name: 'RESPONSE',
    );
    return response;
  }

  /// Extracts the body content of the HTTP request for logging.
  ///
  /// Supports both `http.Request` and `http.MultipartRequest`.
  ///
  /// - Parameters:
  ///   - [request] (`http.BaseRequest`): The outgoing HTTP request.
  /// - Returns:
  ///   - `Future<String>`: The body content of the request as a string.
  String _requestBody(http.BaseRequest request) {
    if (request is http.Request) {
      return request.body;
    } else if (request is http.MultipartRequest) {
      return request.fields.toString();
    }
    return 'Not a http.Request or http.MultipartRequest';
  }

  /// Extracts the body content of the HTTP response for logging.
  String _responseBody(http.BaseResponse response) {
    if (response is http.Response) {
      return response.body;
    }
    return 'Not a http.Response';
  }
}
