import 'app_exception.dart';

/// Network-related exceptions
///
/// This class handles all network-related errors like timeouts,
/// connection issues, and HTTP errors.
class NetworkException extends AppException {
  /// HTTP status code (if applicable)
  final int? statusCode;

  /// The URL that failed
  final String? url;

  /// Create a network exception
  ///
  /// [message] - The error message
  /// [statusCode] - HTTP status code (optional)
  /// [url] - The URL that failed (optional)
  /// [code] - Error code for debugging
  const NetworkException(
    super.message, {
    this.statusCode,
    this.url,
    super.code,
    super.data,
  });

  /// Create a timeout exception
  ///
  /// [url] - The URL that timed out
  factory NetworkException.timeout(String url) {
    return NetworkException(
      'Request timed out. Please check your connection and try again.',
      url: url,
      code: 'TIMEOUT',
    );
  }

  /// Create a connection error exception
  ///
  /// [url] - The URL that failed to connect
  factory NetworkException.connectionError(String url) {
    return NetworkException(
      'No internet connection. Please check your network and try again.',
      url: url,
      code: 'CONNECTION_ERROR',
    );
  }

  /// Create an HTTP error exception
  ///
  /// [statusCode] - HTTP status code
  /// [message] - Error message
  /// [url] - The URL that returned the error
  factory NetworkException.httpError(
    int statusCode,
    String message,
    String url,
  ) {
    String errorMessage;

    switch (statusCode) {
      case 400:
        errorMessage = 'Bad request. Please check your input.';
        break;
      case 401:
        errorMessage = 'Unauthorized. Please login again.';
        break;
      case 403:
        errorMessage = 'Access denied. You don\'t have permission.';
        break;
      case 404:
        errorMessage = 'Resource not found.';
        break;
      case 500:
        errorMessage = 'Server error. Please try again later.';
        break;
      case 502:
        errorMessage = 'Bad gateway. Please try again later.';
        break;
      case 503:
        errorMessage = 'Service unavailable. Please try again later.';
        break;
      default:
        errorMessage = message.isNotEmpty ? message : 'HTTP Error $statusCode';
    }

    return NetworkException(
      errorMessage,
      statusCode: statusCode,
      url: url,
      code: 'HTTP_$statusCode',
    );
  }

  @override
  String toString() {
    final parts = <String>['NetworkException: $message'];

    if (statusCode != null) {
      parts.add('Status: $statusCode');
    }

    if (url != null) {
      parts.add('URL: $url');
    }

    if (code != null) {
      parts.add('Code: $code');
    }

    return parts.join(' | ');
  }
}
