/// Base exception class for the app
///
/// This is the parent class for all custom exceptions in the app.
/// It provides a simple way to handle errors with messages.
class AppException implements Exception {
  /// The error message
  final String message;

  /// Optional error code
  final String? code;

  /// Optional additional data
  final Map<String, dynamic>? data;

  /// Create a new app exception
  ///
  /// [message] - The error message to display
  /// [code] - Optional error code for debugging
  /// [data] - Optional additional data about the error
  const AppException(this.message, {this.code, this.data});

  @override
  String toString() {
    if (code != null) {
      return 'AppException: $message (Code: $code)';
    }
    return 'AppException: $message';
  }
}
