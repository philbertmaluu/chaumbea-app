import '../../core/network/network_client.dart';
import '../constants/api_endpoints.dart';

/// Simple API service for making HTTP requests
///
/// This service provides easy-to-use methods for common API operations
/// and handles the backend response format: {success, data, message}
class ApiService {
  // ===== NETWORK CLIENT =====

  /// The network client instance
  final NetworkClient _client = NetworkClient.instance;

  // ===== AUTHENTICATION METHODS =====

  /// Login user with email and password
  ///
  /// [email] - User's email address
  /// [password] - User's password
  ///
  /// Returns user data on success, throws error message on failure
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );

    // Check if request was successful
    if (response['success'] == true) {
      // Set auth token if provided
      if (response['data']?['token'] != null) {
        _client.setAuthToken(response['data']['token']);
      }
      return response['data'];
    } else {
      throw response['message'] ?? 'Login failed';
    }
  }

  /// Register a new user
  ///
  /// [name] - User's full name
  /// [email] - User's email address
  /// [password] - User's password
  ///
  /// Returns user data on success, throws error message on failure
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      ApiEndpoints.register,
      data: {'name': name, 'email': email, 'password': password},
    );

    // Check if request was successful
    if (response['success'] == true) {
      // Set auth token if provided
      if (response['data']?['token'] != null) {
        _client.setAuthToken(response['data']['token']);
      }
      return response['data'];
    } else {
      throw response['message'] ?? 'Registration failed';
    }
  }

  /// Logout the current user
  ///
  /// Removes the auth token and calls the logout endpoint
  Future<void> logout() async {
    try {
      await _client.post(ApiEndpoints.logout);
    } finally {
      // Always remove the token, even if the request fails
      _client.removeAuthToken();
    }
  }

  // ===== USER PROFILE METHODS =====

  /// Get the current user's profile
  ///
  /// Returns user profile data on success, throws error message on failure
  Future<Map<String, dynamic>> getUserProfile() async {
    final response = await _client.get(ApiEndpoints.userProfile);

    if (response['success'] == true) {
      return response['data'];
    } else {
      throw response['message'] ?? 'Failed to get profile';
    }
  }

  /// Update the current user's profile
  ///
  /// [name] - New name (optional)
  /// [email] - New email (optional)
  /// [phone] - New phone number (optional)
  ///
  /// Returns updated user profile data on success, throws error message on failure
  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? email,
    String? phone,
  }) async {
    final data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;

    final response = await _client.put(ApiEndpoints.updateProfile, data: data);

    if (response['success'] == true) {
      return response['data'];
    } else {
      throw response['message'] ?? 'Failed to update profile';
    }
  }

  /// Change the user's password
  ///
  /// [currentPassword] - Current password
  /// [newPassword] - New password
  ///
  /// Returns success message on success, throws error message on failure
  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await _client.post(
      ApiEndpoints.changePassword,
      data: {'current_password': currentPassword, 'new_password': newPassword},
    );

    if (response['success'] == true) {
      return response['message'] ?? 'Password changed successfully';
    } else {
      throw response['message'] ?? 'Failed to change password';
    }
  }

  // ===== PASSWORD RESET METHODS =====

  /// Send forgot password email
  ///
  /// [email] - User's email address
  ///
  /// Returns success message on success, throws error message on failure
  Future<String> forgotPassword({required String email}) async {
    final response = await _client.post(
      ApiEndpoints.forgotPassword,
      data: {'email': email},
    );

    if (response['success'] == true) {
      return response['message'] ?? 'Password reset email sent';
    } else {
      throw response['message'] ?? 'Failed to send reset email';
    }
  }

  /// Reset password with token
  ///
  /// [token] - Reset token from email
  /// [password] - New password
  ///
  /// Returns success message on success, throws error message on failure
  Future<String> resetPassword({
    required String token,
    required String password,
  }) async {
    final response = await _client.post(
      ApiEndpoints.resetPassword,
      data: {'token': token, 'password': password},
    );

    if (response['success'] == true) {
      return response['message'] ?? 'Password reset successfully';
    } else {
      throw response['message'] ?? 'Failed to reset password';
    }
  }

  // ===== GENERIC METHODS =====

  /// Get data from any endpoint
  ///
  /// [endpoint] - The API endpoint
  /// [queryParams] - Optional query parameters
  ///
  /// Returns data on success, throws error message on failure
  Future<dynamic> getData(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    final response = await _client.get(endpoint, queryParams: queryParams);

    if (response['success'] == true) {
      return response['data'];
    } else {
      throw response['message'] ?? 'Request failed';
    }
  }

  /// Post data to any endpoint
  ///
  /// [endpoint] - The API endpoint
  /// [data] - Data to send
  ///
  /// Returns data on success, throws error message on failure
  Future<dynamic> postData(String endpoint, {dynamic data}) async {
    final response = await _client.post(endpoint, data: data);

    if (response['success'] == true) {
      return response['data'];
    } else {
      throw response['message'] ?? 'Request failed';
    }
  }

  // ===== UTILITY METHODS =====

  /// Set authentication token manually
  ///
  /// [token] - JWT token
  void setAuthToken(String token) {
    _client.setAuthToken(token);
  }

  /// Remove authentication token
  void removeAuthToken() {
    _client.removeAuthToken();
  }
}

// ===== USAGE EXAMPLE =====
/*
/// Example of how to use the simplified ApiService:

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiService _apiService = ApiService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    try {
      setState(() => _isLoading = true);
      
      // Call login API
      final userData = await _apiService.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
      
      // Handle success
      print('Login successful: ${userData['name']}');
      Navigator.pushReplacementNamed(context, '/home');
      
    } catch (e) {
      // Handle any error - just show the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _getRequests() async {
    try {
      // Get air ticket requests (example from your backend)
      final requests = await _apiService.getData('/air-ticket-requests');
      
      // requests will be the data array from your backend
      for (var request in requests) {
        print('Request ID: ${request['requestid']}');
        print('Title: ${request['title']}');
        print('Status: ${request['status']}');
      }
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _login,
              child: Text(_isLoading ? 'Loading...' : 'Login'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Example of handling your backend response format:
/// 
/// Your backend returns:
/// {
///   "success": true,
///   "data": [
///     {
///       "requestid": "15475",
///       "cdate": "2024-10-28 13:16:44",
///       "batchno": "1008619",
///       "title": "CODE OF ETHICS AND CONDUCT TRAINING",
///       "pfno": "4956",
///       "fullname": "Hawa Abdi Kimaro",
///       "status": "PENDING",
///       "approval_document": "https://fms-api.nssf.go.tz/api/view-approval?reference_no=e08dcb78f2065240f0be83ebe14e1601"
///     }
///   ],
///   "message": "Air ticket requests for batch retrieved successfully"
/// }
/// 
/// Usage:
/// 
/// try {
///   final requests = await apiService.getData('/air-ticket-requests');
///   
///   // requests is now the data array directly
///   for (var request in requests) {
///     print('ID: ${request['requestid']}');
///     print('Title: ${request['title']}');
///     print('Status: ${request['status']}');
///     print('Name: ${request['fullname']}');
///   }
///   
/// } catch (e) {
///   // e will be the error message from your backend
///   print('Error: $e');
/// }
*/
