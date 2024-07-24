import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:networking_service/src/exception.dart';
import 'package:networking_service/src/networking_service.dart';
import 'package:networking_service/src/utils/map_merger.dart';
import 'package:networking_service/src/utils/response_parser.dart';

// TODO: Actually implement and test, compare to the one in Taktikat.
class DioNetworkingService extends NetworkingService {
  DioNetworkingService({
    required super.baseUrl,
    required super.defaultHeaders,
    required this.dio,
  });
  final Dio dio;

  @override
  Future<T> request<T>(
    String endpoint, {
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, String>? files,
  }) async {
    final url = '${super.baseUrl}/$endpoint';
    final mergedHeaders = defaultHeaders.mergeWith(headers);

    return switch (method) {
      HttpMethod.get =>
        _get<T>(url, headers: mergedHeaders, queryParameters: body),
      HttpMethod.post => _post(url, body: body, headers: mergedHeaders),
      HttpMethod.patch => _patch(url, body: body, headers: mergedHeaders),
      HttpMethod.put => _put(url, body: body, headers: mergedHeaders),
      HttpMethod.delete => _delete(url, headers: mergedHeaders, body: body),
      HttpMethod.multipartPost => _multipartRequest(url,
          body: body, headers: mergedHeaders, files: files, method: 'POST'),
      HttpMethod.multipartPatch => _multipartRequest(url,
          body: body, headers: mergedHeaders, files: files, method: 'PATCH'),
      HttpMethod.multipartPut => _multipartRequest(url,
          body: body, headers: mergedHeaders, files: files, method: 'PUT'),
    };
  }

  Future<T> _get<T>(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        // Uri.parse(url).replace(queryParameters: queryParameters),
        url,
        queryParameters: queryParameters,
        // headers: headers,
        options: Options(
          headers: headers,
        ),
      );
      return parseResponse<T>(response.data);
    } catch (error) {
      throw NetworkException(
        'Failed to perform GET request: $error on Endpoint $url',
      );
    }
  }

  Future<T> _post<T>(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: body != null ? jsonEncode(body) : null,
        options: Options(headers: headers),
      );

      return parseResponse<T>(response.data);
    } catch (error) {
      throw NetworkException(
        'Failed to perform POST request: $error on Endpoint $url',
      );
    }
  }

  Future<T> _patch<T>(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.patch(
        url,
        data: body != null ? jsonEncode(body) : null,
        options: Options(headers: headers),
      );
      return parseResponse<T>(response.data);
    } catch (error) {
      throw NetworkException(
        'Failed to perform PATCH request with error: $error on Endpoint $url',
      );
    }
  }

  Future<T> _put<T>(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.put(
        url,
        data: body != null ? jsonEncode(body) : null,
        options: Options(headers: headers),
      );
      return parseResponse<T>(response.data);
    } catch (error) {
      throw NetworkException(
        'Failed to perform PUT request with error: $error on Endpoint $url',
      );
    }
  }

  Future<T> _delete<T>(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.delete(
        url,
        data: body != null ? jsonEncode(body) : null,
        options: Options(headers: headers),
      );
      return parseResponse<T>(response.data);
    } catch (error) {
      throw NetworkException(
        'Failed to perform DELETE request with error: $error on Endpoint $url',
      );
    }
  }

  Future<T> _multipartRequest<T>(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, String>? files,
    required String method,
  }) async {
    final response = await dio.post(
      url,
      data: FormData.fromMap(body ?? {}),
    );

    return parseResponse<T>(response.data);
  }
}
