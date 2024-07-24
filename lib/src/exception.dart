
class NetworkException implements Exception {
  const NetworkException(this.message);
  final String message;

  @override
  String toString() => 'NetworkException: $message';
}
