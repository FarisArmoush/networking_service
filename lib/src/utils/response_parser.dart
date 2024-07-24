// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

/// Parses the given JSON [responseBody] into the specified type [T].
///
/// Supported types for [T] are:
/// - `String`: Returns the raw JSON string.
/// - `Map<String, dynamic>`: Parses the JSON string into a map.
/// - `List<Map<String, dynamic>>`: Parses the JSON string into a list of maps.
///
/// Example:
/// ```dart
/// String jsonString = '{"key": "value"}';
/// Map<String, dynamic> result = parseResponse<Map<String, dynamic>>(jsonString);
/// print(result); // Output: {key: value}
/// ```
///
/// ```dart
/// String jsonArrayString = '[{"key1": "value1"}, {"key2": "value2"}]';
/// List<Map<String, dynamic>> resultList = parseResponse<List<Map<String, dynamic>>>(jsonArrayString);
/// print(resultList); // Output: [{key1: value1}, {key2: value2}]
/// ```
///
/// - Parameter responseBody: The JSON string to be parsed.
/// - Returns: The parsed object of type [T].
/// - Throws: [UnimplementedError] if the type [T] is unsupported.
T parseResponse<T>(String responseBody) {
  switch (T) {
    case const (String):
      return responseBody as T;

    case const (Map<String, dynamic>):
      return jsonDecode(responseBody) as T;

    case const (List<Map<String, dynamic>>):
      final decodedList = jsonDecode(responseBody) as Iterable<dynamic>;
      return List<Map<String, dynamic>>.from(decodedList) as T;

    default:
      throw UnimplementedError('${T.runtimeType} is unsupported');
  }
}
