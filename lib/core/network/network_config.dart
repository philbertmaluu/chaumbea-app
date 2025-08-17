/// Simple network configuration for the app
///
/// This class contains basic network settings like base URL and timeouts.
class NetworkConfig {
  // ===== BASE URL =====

  /// The base URL for all API calls
  /// Change this to switch between development, staging, and production
  static const String baseUrl = 'https://api.chaumbea.com';

  // ===== TIMEOUT SETTINGS =====

  /// How long to wait for connection (30 seconds)
  static const Duration connectTimeout = Duration(seconds: 30);

  /// How long to wait for response (30 seconds)
  static const Duration receiveTimeout = Duration(seconds: 30);

  // ===== DEFAULT HEADERS =====

  /// Default headers sent with every request
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // ===== UTILITY METHODS =====

  /// Get the full URL by combining base URL with endpoint
  ///
  /// Example: getFullUrl('/auth/login') returns 'https://api.chaumbea.com/auth/login'
  static String getFullUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
}
