/// A custom exception class for network-related errors.
///
/// This exception is thrown when a network request fails, providing a message
/// that describes the error.
///
/// Example usage:
/// ```dart
/// try {
///   final response = await httpNetworkService.request('endpoint');
/// } catch (e) {
///   if (e is NetworkException) {
///     print(e); // Output: NetworkException: Error message
///   }
/// }
/// ```
class NetworkException implements Exception {
  /// Constructs a [NetworkException] with the given error [message].
  const NetworkException(this.message);

  /// The error message describing the network exception.
  final String message;

  /// Returns a string representation of the exception.
  ///
  /// The output format is: `NetworkException: [message]`.
  @override
  String toString() => 'NetworkException: $message';
}
