import 'package:flutter/material.dart';
import 'app_exception.dart';
import 'auth_exception.dart';
import 'network_exception.dart';

/// Simple exception handler for the app
///
/// This class provides easy methods to handle different types of exceptions
/// and show appropriate error messages to users.
class ExceptionHandler {
  /// Handle any exception and show a user-friendly message
  ///
  /// [context] - BuildContext for showing SnackBar
  /// [exception] - The exception to handle
  /// [title] - Optional title for the error (default: "Error")
  static void handleException(
    BuildContext context,
    dynamic exception, {
    String title = 'Error',
  }) {
    String message;

    if (exception is AuthException) {
      message = _getAuthErrorMessage(exception);
    } else if (exception is NetworkException) {
      message = _getNetworkErrorMessage(exception);
    } else if (exception is AppException) {
      message = exception.message;
    } else {
      message = 'An unexpected error occurred. Please try again.';
    }

    _showErrorSnackBar(context, title, message);
  }

  /// Handle authentication exceptions
  ///
  /// [context] - BuildContext for showing SnackBar
  /// [exception] - The AuthException to handle
  static void handleAuthException(
    BuildContext context,
    AuthException exception,
  ) {
    final message = _getAuthErrorMessage(exception);
    _showErrorSnackBar(context, 'Authentication Error', message);
  }

  /// Handle network exceptions
  ///
  /// [context] - BuildContext for showing SnackBar
  /// [exception] - The NetworkException to handle
  static void handleNetworkException(
    BuildContext context,
    NetworkException exception,
  ) {
    final message = _getNetworkErrorMessage(exception);
    _showErrorSnackBar(context, 'Network Error', message);
  }

  /// Get user-friendly message for authentication errors
  static String _getAuthErrorMessage(AuthException exception) {
    switch (exception.type) {
      case AuthErrorType.invalidCredentials:
        return 'Invalid email or password. Please check your credentials and try again.';
      case AuthErrorType.expiredToken:
        return 'Your session has expired. Please login again.';
      case AuthErrorType.unauthorized:
        return 'You are not authorized to perform this action.';
      case AuthErrorType.emailAlreadyExists:
        return 'An account with this email already exists. Please use a different email.';
      case AuthErrorType.weakPassword:
        return 'Password is too weak. Please choose a stronger password.';
      case AuthErrorType.invalidEmail:
        return 'Please enter a valid email address.';
      case AuthErrorType.passwordResetFailed:
        return 'Password reset failed. Please try again.';
      case AuthErrorType.accountNotFound:
        return 'No account found with this email address.';
    }
  }

  /// Get user-friendly message for network errors
  static String _getNetworkErrorMessage(NetworkException exception) {
    if (exception.statusCode != null) {
      switch (exception.statusCode) {
        case 400:
          return 'Bad request. Please check your input and try again.';
        case 401:
          return 'Unauthorized. Please login again.';
        case 403:
          return 'Access denied. You don\'t have permission for this action.';
        case 404:
          return 'Resource not found.';
        case 500:
          return 'Server error. Please try again later.';
        case 502:
          return 'Bad gateway. Please try again later.';
        case 503:
          return 'Service unavailable. Please try again later.';
        default:
          return exception.message;
      }
    }

    return exception.message;
  }

  /// Show error message as SnackBar
  static void _showErrorSnackBar(
    BuildContext context,
    String title,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(message, style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// Show success message as SnackBar
  static void showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show info message as SnackBar
  static void showInfoMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
