import 'dart:io';

class ApiConstants {
  static String get baseUrl {
    const envValue = String.fromEnvironment('API_BASE_URL');
    if (envValue.isNotEmpty) {
      return envValue;
    }
    return Platform.isAndroid || Platform.isIOS
        ? 'http://172.30.11.76:8000' // Your Laptop/Server IP
        : 'http://localhost:8000';
  }

  static String get authLogin => '$baseUrl/api/v1/auth/login';
  static String get authSignup => '$baseUrl/api/v1/auth/register';
  static String get authOAuthCallback => '$baseUrl/api/v1/auth/oauth/callback';
}
