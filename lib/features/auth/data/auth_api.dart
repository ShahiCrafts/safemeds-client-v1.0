import 'dart:convert';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_constants.dart';
import 'auth_models.dart';

class AuthApi {
  final ApiClient _client;

  AuthApi([ApiClient? client]) : _client = client ?? ApiClient();

  Future<TokenResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.postJson(ApiConstants.authLogin, {
      'email': email,
      'password': password,
    });

    if (response.statusCode != 200) {
      String message = 'Login failed';
      try {
        final error = jsonDecode(response.body);
        message = error['detail'] ?? error['message'] ?? message;
      } catch (_) {
        // Not a JSON response, likely an HTML 500 error
        message = 'Server Error: ${response.statusCode}';
      }
      throw Exception(message);
    }

    return TokenResponse.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  Future<User> signup({
    required String fullName,
    required String email,
    String? phone,
    required String password,
    String role = 'patient',
  }) async {
    final response = await _client.postJson(ApiConstants.authSignup, {
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
    });

    if (response.statusCode != 201 && response.statusCode != 200) {
      String message = 'Signup failed';
      try {
        final error = jsonDecode(response.body);
        message = error['detail'] ?? error['message'] ?? message;
      } catch (_) {
        message = 'Server Error: ${response.statusCode}';
      }
      throw Exception(message);
    }

    return User.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
  
  Future<TokenResponse> googleLogin({required String idToken}) async {
    final response = await _client.postJson(ApiConstants.authOAuthCallback, {
      'provider': 'google',
      'id_token': idToken,
    });

    if (response.statusCode != 200) {
      String message = 'Google Login failed';
      try {
        final error = jsonDecode(response.body);
        message = error['detail'] ?? error['message'] ?? message;
      } catch (_) {
        message = 'Server Error: ${response.statusCode}';
      }
      throw Exception(message);
    }

    return TokenResponse.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
