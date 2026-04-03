import 'package:get/get.dart';

class AuthService extends GetConnect {
  // Ganti dengan IP VPS atau domain API Anda - /POST/ bukan bagian dari path!
  final String baseUrlPath = "https://be-internship.bccdev.id/ragil/auth"; 

  AuthService() {
    httpClient.baseUrl = baseUrlPath;
    httpClient.timeout = const Duration(seconds: 30);
  }

  Future<Response> loginUser(String email, String password) async {
    try {
      final response = await post(
        '/login',
        {
          "email": email,
          "password": password,
        },
      );
      return response;
    } catch (e) {
      print("API Error: $e");
      rethrow;
    }
  }
}