import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:networking_service/src/exception.dart';
import 'package:networking_service/src/networking_service.dart';
import 'package:networking_service/src/utils/map_merger.dart';
import 'package:networking_service/src/utils/response_parser.dart';

class HttpNetworkService extends NetworkingService {
  const HttpNetworkService({
    required super.baseUrl,
    required this.client,
    super.defaultHeaders,
  });

  final http.Client client;

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
      final response = await client.get(
        Uri.parse(url).replace(queryParameters: queryParameters),
        headers: headers,
      );
      return parseResponse<T>(response.body);
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
      final response = await client.post(
        Uri.parse(url),
        body: body != null ? jsonEncode(body) : null,
        headers: headers,
      );

      return parseResponse<T>(response.body);
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
      final response = await client.patch(
        Uri.parse(url),
        body: body != null ? jsonEncode(body) : null,
        headers: headers,
      );
      return parseResponse<T>(response.body);
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
      final response = await client.put(
        Uri.parse(url),
        body: body != null ? jsonEncode(body) : null,
        headers: headers,
      );
      return parseResponse<T>(response.body);
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
      final response = await client.delete(
        Uri.parse(url),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );
      return parseResponse<T>(response.body);
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
    final request = http.MultipartRequest(method, Uri.parse(url));
    if (headers != null) {
      request.headers.addAll(headers);
    }
    if (body != null) {
      body.forEach((key, value) {
        request.fields[key] = value.toString();
      });
    }
    if (files != null) {
      for (var entry in files.entries) {
        request.files
            .add(await http.MultipartFile.fromPath(entry.key, entry.value));
      }
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return parseResponse<T>(response.body);
  }
}
