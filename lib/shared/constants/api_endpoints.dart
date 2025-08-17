/// API Endpoints for the Chaumbea application
///
/// This file contains all the API endpoint URLs used throughout the app.
/// Each endpoint is documented with its purpose and expected data format.
class ApiEndpoints {
  // ===== AUTHENTICATION ENDPOINTS =====

  /// Login endpoint
  ///
  /// POST /auth/login
  /// Body: { "email": "string", "password": "string" }
  /// Returns: { "token": "string", "user": {...} }
  static const String login = '/auth/login';

  /// Register endpoint
  ///
  /// POST /auth/register
  /// Body: { "name": "string", "email": "string", "password": "string" }
  /// Returns: { "token": "string", "user": {...} }
  static const String register = '/auth/register';

  /// Logout endpoint
  ///
  /// POST /auth/logout
  /// Headers: { "Authorization": "Bearer token" }
  /// Returns: { "message": "string" }
  static const String logout = '/auth/logout';

  /// Forgot password endpoint
  ///
  /// POST /auth/forgot-password
  /// Body: { "email": "string" }
  /// Returns: { "message": "string" }
  static const String forgotPassword = '/auth/forgot-password';

  /// Reset password endpoint
  ///
  /// POST /auth/reset-password
  /// Body: { "token": "string", "password": "string" }
  /// Returns: { "message": "string" }
  static const String resetPassword = '/auth/reset-password';

  // ===== USER ENDPOINTS =====

  /// Get user profile
  ///
  /// GET /user/profile
  /// Headers: { "Authorization": "Bearer token" }
  /// Returns: { "user": {...} }
  static const String userProfile = '/user/profile';

  /// Update user profile
  ///
  /// PUT /user/profile
  /// Headers: { "Authorization": "Bearer token" }
  /// Body: { "name": "string", "email": "string", "phone": "string" }
  /// Returns: { "user": {...} }
  static const String updateProfile = '/user/profile';

  /// Change password
  ///
  /// POST /user/change-password
  /// Headers: { "Authorization": "Bearer token" }
  /// Body: { "current_password": "string", "new_password": "string" }
  /// Returns: { "message": "string" }
  static const String changePassword = '/user/change-password';

  // ===== FILE UPLOAD ENDPOINTS =====

  /// Upload image
  ///
  /// POST /upload/image
  /// Headers: { "Authorization": "Bearer token" }
  /// Body: FormData with image file
  /// Returns: { "url": "string" }
  static const String uploadImage = '/upload/image';

  /// Upload document
  ///
  /// POST /upload/document
  /// Headers: { "Authorization": "Bearer token" }
  /// Body: FormData with document file
  /// Returns: { "url": "string" }
  static const String uploadDocument = '/upload/document';
}
