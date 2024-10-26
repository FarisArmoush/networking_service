***Networking Service***

A generic networking service for Flutter applications with two implementations based on the dio and http packages. This service offers a flexible and reusable solution for making HTTP requests, supporting standard HTTP methods as well as multipart requests for file uploads. With structured error handling, request/response logging, and token management, it’s designed to be robust and easy to integrate.

Features

	•	Supports Multiple HTTP Methods: Provides GET, POST, PUT, PATCH, DELETE, and multipart methods for file uploads.
	•	Generic Response Parsing: Returns parsed responses with support for String, Map, and List<Map>.
	•	Logging Interceptors: Logs detailed information on requests, responses, and errors.
	•	Token Management: Optionally includes token-based authorization headers for requests.
	•	Error Handling: Centralized error handling via a custom NetworkException.

Installation

	1.	Add dependencies in your pubspec.yaml:

```yaml
dependencies:
  dio: ^4.0.0
  http: ^0.13.3
  shared_preferences: ^2.0.6
 ```


	2.	Import the necessary packages in your Dart file:

```dart
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
```



Setup

To initialize the networking service, you can choose between HttpNetworkService and DioNetworkingService, depending on your preferred package.

Example Usage

// Initializing with Dio
final dioNetworkingService = DioNetworkingService(
  baseUrl: 'https://api.example.com',
  dio: Dio()..interceptors.add(DioLoggingInterceptor()),
  defaultHeaders: {'Content-Type': 'application/json'},
);

// Initializing with Http
final httpNetworkingService = HttpNetworkService(
  baseUrl: 'https://api.example.com',
  client: http.Client(),
  defaultHeaders: {'Content-Type': 'application/json'},
);

Making Requests

Both services provide a unified request method, where you specify the endpoint, HTTP method, and optional parameters.
```dart
// Making a GET request
final response = await dioNetworkingService.request<Map<String, dynamic>>(
  'endpoint',
  method: HttpMethod.get,
  headers: {'Authorization': 'Bearer your_token'},
);
```

Multipart Requests

For file uploads, use the multipart methods like multipartPost, multipartPut, or multipartPatch.
```dart
// Making a Multipart POST request
final response = await dioNetworkingService.request<String>(
  'endpoint',
  method: HttpMethod.multipartPost,
  files: {'file': 'path/to/file'},
  body: {'key': 'value'},
);
```

Available Classes and Methods

Enum: HttpMethod

Defines the HTTP methods supported by the service:

	•	get
	•	post
	•	put
	•	patch
	•	delete
	•	multipartPost
	•	multipartPut
	•	multipartPatch

Class: NetworkingService

The abstract base class that other services inherit from. Defines:

	•	baseUrl: Base URL for requests.
	•	defaultHeaders: Default headers applied to each request.
	•	request<T>: A generic method to make requests, which is overridden in implementations.

Class: HttpNetworkService

Implementation of NetworkingService using the http package. Contains:

	•	client: The HTTP client to perform requests.
	•	Methods for GET, POST, PATCH, PUT, DELETE, and multipart requests.

Class: DioNetworkingService

Implementation of NetworkingService using Dio. Contains:

	•	dio: The Dio client to perform requests.
	•	Methods for GET, POST, PATCH, PUT, DELETE, and multipart requests.

Custom Exception: NetworkException

Used for network-related errors with a clear message.

Utility Extension: MapMerger

A helper extension to merge two maps, prioritizing values from the second map.

Function: parseResponse

A utility function that parses the response based on the specified type (String, Map, or List).

Interceptors

DioLoggingInterceptor

Logs detailed information about Dio requests, responses, and errors, including timestamps and durations.

DioTokenInterceptor

Fetches and adds a token from SharedPreferences to the headers for authorization purposes.

HttpLoggingInterceptor

Logs details of HTTP requests and responses in the http package, including the request method, URL, headers, and body.

HttpTokenInterceptor

Fetches and attaches a token from SharedPreferences to the headers for authorization.

Error Handling

All methods use the NetworkException class to provide a custom error message when a request fails. For example:
```dart
try {
  final response = await dioNetworkingService.request('endpoint');
} on NetworkException catch (e) {
   print(e.message);
}
```

Contributing

If you’d like to contribute, please fork the repository and submit a pull request.

This README should provide clear guidance for users to integrate and use the networking service with either dio or http.