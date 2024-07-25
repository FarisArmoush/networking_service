import 'package:flutter_test/flutter_test.dart';
import 'package:networking_service/src/utils/response_parser.dart';

void main() {
  group('parseResponse', () {
    test('should parse JSON string into a raw string', () {
      const jsonString = '{"key": "value"}';
      final result = parseResponse<String>(jsonString);
      expect(result, jsonString);
    });

    test('should parse JSON string into a map', () {
      const jsonString = '{"key": "value"}';
      final result = parseResponse<Map<String, dynamic>>(jsonString);
      expect(result, isA<Map<String, dynamic>>());
      expect(result, {'key': 'value'});
    });

    test('should parse JSON string into a list of maps', () {
      const jsonArrayString = '[{"key1": "value1"}, {"key2": "value2"}]';
      final result = parseResponse<List<Map<String, dynamic>>>(jsonArrayString);
      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result, [
        {'key1': 'value1'},
        {'key2': 'value2'}
      ]);
    });

    test('should throw UnimplementedError for unsupported type', () {
      const jsonString = '{"key": "value"}';
      expect(
        () => parseResponse<int>(jsonString),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
