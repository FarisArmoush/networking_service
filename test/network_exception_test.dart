import 'package:flutter_test/flutter_test.dart';
import 'package:networking_service/src/network_exception.dart';

void main() {
  group('NetworkException', () {
    test('should return correct message', () {
      const message = 'An error occurred';
      const exception = NetworkException(message);

      expect(exception.message, message);
    });

    test('toString should return correct format', () {
      const message = 'An error occurred';
      const exception = NetworkException(message);

      expect(exception.toString(), 'NetworkException: $message');
    });
  });
}
