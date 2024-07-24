enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete,
  multipartPost,
  multipartPut,
  multipartPatch,
}

abstract class NetworkingService {
  const NetworkingService({
    required this.baseUrl,
    required this.defaultHeaders,
  });

  final String baseUrl;
  final Map<String, String>? defaultHeaders;

  Future<T> request<T>(
    String endpoint, {
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
}
