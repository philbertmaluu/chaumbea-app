import 'package:dio/dio.dart';
import 'network_config.dart';

/// Simple HTTP client for making API calls
///
/// This class provides easy-to-use methods for GET, POST, PUT, and DELETE requests.
class NetworkClient {
  // ===== SINGLETON INSTANCE =====

  /// Single instance of the network client
  static final NetworkClient _instance = NetworkClient._internal();

  /// Get the network client instance
  static NetworkClient get instance => _instance;

  NetworkClient._internal() {
    _dio = Dio(_createOptions());
  }

  // ===== DIO INSTANCE =====

  late final Dio _dio;

  /// Create basic Dio options
  BaseOptions _createOptions() {
    return BaseOptions(
      baseUrl: NetworkConfig.baseUrl,
      connectTimeout: NetworkConfig.connectTimeout,
      receiveTimeout: NetworkConfig.receiveTimeout,
      headers: NetworkConfig.defaultHeaders,
    );
  }

  // ===== HTTP METHODS =====

  /// Make a GET request
  ///
  /// [endpoint] - The API endpoint (e.g., '/user/profile')
  /// [queryParams] - Optional query parameters
  ///
  /// Returns the response data
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return response.data;
    } catch (e) {
      throw _getErrorMessage(e);
    }
  }

  /// Make a POST request
  ///
  /// [endpoint] - The API endpoint (e.g., '/auth/login')
  /// [data] - The data to send in the request body
  ///
  /// Returns the response data
  Future<Map<String, dynamic>> post(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw _getErrorMessage(e);
    }
  }

  /// Make a PUT request
  ///
  /// [endpoint] - The API endpoint (e.g., '/user/profile')
  /// [data] - The data to send in the request body
  ///
  /// Returns the response data
  Future<Map<String, dynamic>> put(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw _getErrorMessage(e);
    }
  }

  /// Make a DELETE request
  ///
  /// [endpoint] - The API endpoint (e.g., '/user/account')
  ///
  /// Returns the response data
  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return response.data;
    } catch (e) {
      throw _getErrorMessage(e);
    }
  }

  // ===== AUTHENTICATION =====

  /// Add authorization token to all requests
  ///
  /// [token] - The JWT token from login
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Remove authorization token
  void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  // ===== SIMPLE ERROR HANDLING =====

  /// Get simple error message from any error
  String _getErrorMessage(dynamic error) {
    if (error is DioException) {
      // Try to get error message from response
      if (error.response?.data is Map<String, dynamic>) {
        final data = error.response!.data as Map<String, dynamic>;
        return data['message'] ?? data['error'] ?? 'Network error occurred';
      }

      // Handle different error types
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Request timeout. Please try again.';
        case DioExceptionType.connectionError:
          return 'No internet connection. Please check your network.';
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 401) {
            return 'Unauthorized. Please login again.';
          } else if (statusCode == 404) {
            return 'Resource not found.';
          } else if (statusCode == 500) {
            return 'Server error. Please try again later.';
          }
          return 'Error: ${error.response?.statusCode}';
        default:
          return 'Network error: ${error.message}';
      }
    }

    return 'An unexpected error occurred: $error';
  }
}
