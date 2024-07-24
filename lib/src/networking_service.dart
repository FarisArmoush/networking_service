/// An enumeration of HTTP methods used in network requests.
enum HttpMethod {
  /// The HTTP GET method is used to retrieve data from a server.
  get,

  /// The HTTP POST method is used to send data to a server to create
  /// a new resource.
  post,

  /// The HTTP PUT method is used to send data to a server to update an
  /// existing resource.
  put,

  /// The HTTP PATCH method is used to apply partial modifications to a resource
  patch,

  /// The HTTP DELETE method is used to delete a resource from a server.
  delete,

  /// The HTTP multipart POST method is used to send data to a server,
  /// typically for file uploads.
  multipartPost,

  /// The HTTP multipart PUT method is used to send data to a server, typically
  /// for file uploads to update an existing resource.
  multipartPut,

  /// The HTTP multipart PATCH method is used to apply partial modifications to
  /// a resource, typically for file uploads.
  multipartPatch,
}

/// An abstract class representing a networking service.
///
/// This class provides a base for making network requests with specified
/// [baseUrl] and optional [defaultHeaders]. Subclasses should implement the
/// [request] method to handle HTTP requests.
///
/// Example usage:
/// ```dart
/// class HttpNetworkingService extends NetworkingService {
///   HttpNetworkingService(baseUrl: 'https://api.example.com', defaultHeaders: {'Authorization': 'Bearer token'});
///
///   @override
///   Future<T> request<T>(
///     String endpoint, {
///     required HttpMethod method,
///     Map<String, dynamic>? body,
///     Map<String, String>? headers,
///     Map<String, String>? files,
///   }) async {
///     // Implement the request logic here
///   }
/// }
/// ```
///
/// - [baseUrl]: The base URL for the network requests.
/// - [defaultHeaders]: The default headers to be included in each request.
abstract class NetworkingService {
  /// Constructs a [NetworkingService] with the given [baseUrl]
  /// and optional [defaultHeaders].
  const NetworkingService({
    required this.baseUrl,
    required this.defaultHeaders,
  });

  /// The base URL for the network requests.
  final String baseUrl;

  /// The default headers to be included in each request.
  final Map<String, String>? defaultHeaders;

  /// Makes a network request to the specified [endpoint] with the given [method]
  ///
  /// Optionally, a [body] and [headers] can be provided.
  ///
  /// - [endpoint]: The endpoint to make the request to, relative to [baseUrl].
  /// - [method]: The HTTP method to use for the request.
  /// - [body]: The request body, typically used with POST, PUT, and PATCH
  /// methods.
  /// - [headers]: Additional headers to include in the request.
  ///
  /// Returns a future of type [T] representing the response of the request.
  ///
  /// Subclasses should implement this method to handle the specifics of
  /// the network request.
  Future<T> request<T>(
    String endpoint, {
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, String>? files,
  });
}
