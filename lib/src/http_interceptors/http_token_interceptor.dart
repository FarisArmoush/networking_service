import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/models/interceptor_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A class that intercepts HTTP requests and responses for logging purposes.
class HttpTokenInterceptor extends InterceptorContract {
  @override
  FutureOr<http.BaseRequest> interceptRequest({
    required http.BaseRequest request,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    return request;
  }

  @override
  FutureOr<http.BaseResponse> interceptResponse({
    required http.BaseResponse response,
  }) {
    return response;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() => false;
}
