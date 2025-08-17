import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Simple logging interceptor for debugging API calls
///
/// This interceptor logs all requests and responses to help with debugging.
/// It only logs in debug mode to avoid performance issues in production.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Only log in debug mode
    if (kDebugMode) {
      print('🌐 REQUEST: ${options.method} ${options.path}');
      if (options.data != null) {
        print('📦 Data: ${options.data}');
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Only log in debug mode
    if (kDebugMode) {
      print(
        '✅ RESPONSE: ${response.statusCode} ${response.requestOptions.path}',
      );
      print('📦 Data: ${response.data}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Only log in debug mode
    if (kDebugMode) {
      print('❌ ERROR: ${err.response?.statusCode} ${err.requestOptions.path}');
      print('💬 Message: ${err.message}');
    }
    handler.next(err);
  }
}
