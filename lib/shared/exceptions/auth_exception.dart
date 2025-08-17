import 'app_exception.dart';

/// Authentication-related exceptions
///
/// This class handles all authentication errors like invalid credentials,
/// expired tokens, and registration issues.
class AuthException extends AppException {
  /// The type of authentication error
  final AuthErrorType type;

  /// Create an authentication exception
  ///
  /// [message] - The error message
  /// [type] - The type of authentication error
  /// [code] - Error code for debugging
  const AuthException(
    super.message, {
    required this.type,
    super.code,
    super.data,
  });

  /// Create an invalid credentials exception
  ///
  /// [message] - Custom error message (optional)
  factory AuthException.invalidCredentials([String? message]) {
    return AuthException(
      message ?? 'Invalid email or password. Please try again.',
      type: AuthErrorType.invalidCredentials,
      code: 'INVALID_CREDENTIALS',
    );
  }

  /// Create an expired token exception
  ///
  /// [message] - Custom error message (optional)
  factory AuthException.expiredToken([String? message]) {
    return AuthException(
      message ?? 'Your session has expired. Please login again.',
      type: AuthErrorType.expiredToken,
      code: 'EXPIRED_TOKEN',
    );
  }

  /// Create an unauthorized exception
  ///
  /// [message] - Custom error message (optional)
  factory AuthException.unauthorized([String? message]) {
    return AuthException(
      message ?? 'You are not authorized to perform this action.',
      type: AuthErrorType.unauthorized,
      code: 'UNAUTHORIZED',
    );
  }

  /// Create an email already exists exception
  ///
  /// [email] - The email that already exists
  factory AuthException.emailAlreadyExists(String email) {
    return AuthException(
      'An account with email "$email" already exists.',
      type: AuthErrorType.emailAlreadyExists,
      code: 'EMAIL_EXISTS',
      data: {'email': email},
    );
  }

  /// Create a weak password exception
  ///
  /// [message] - Custom error message (optional)
  factory AuthException.weakPassword([String? message]) {
    return AuthException(
      message ?? 'Password is too weak. Please choose a stronger password.',
      type: AuthErrorType.weakPassword,
      code: 'WEAK_PASSWORD',
    );
  }

  /// Create an invalid email exception
  ///
  /// [email] - The invalid email
  factory AuthException.invalidEmail(String email) {
    return AuthException(
      'Invalid email format: "$email"',
      type: AuthErrorType.invalidEmail,
      code: 'INVALID_EMAIL',
      data: {'email': email},
    );
  }

  /// Create a password reset failed exception
  ///
  /// [message] - Custom error message (optional)
  factory AuthException.passwordResetFailed([String? message]) {
    return AuthException(
      message ?? 'Password reset failed. Please try again.',
      type: AuthErrorType.passwordResetFailed,
      code: 'PASSWORD_RESET_FAILED',
    );
  }

  /// Create an account not found exception
  ///
  /// [email] - The email that was not found
  factory AuthException.accountNotFound(String email) {
    return AuthException(
      'No account found with email "$email"',
      type: AuthErrorType.accountNotFound,
      code: 'ACCOUNT_NOT_FOUND',
      data: {'email': email},
    );
  }

  @override
  String toString() {
    final parts = <String>['AuthException: $message'];
    parts.add('Type: ${type.name}');

    if (code != null) {
      parts.add('Code: $code');
    }

    return parts.join(' | ');
  }
}

/// Types of authentication errors
enum AuthErrorType {
  /// Invalid email or password
  invalidCredentials,

  /// Token has expired
  expiredToken,

  /// User is not authorized
  unauthorized,

  /// Email already exists during registration
  emailAlreadyExists,

  /// Password is too weak
  weakPassword,

  /// Invalid email format
  invalidEmail,

  /// Password reset failed
  passwordResetFailed,

  /// Account not found
  accountNotFound,
}
