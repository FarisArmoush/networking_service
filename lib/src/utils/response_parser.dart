import 'dart:convert';

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
