import 'package:get/get.dart';

class RegisterService extends GetConnect {
  // Endpoint API untuk register - /POST/ bukan bagian dari path!
  final String baseUrlPath = "https://be-internship.bccdev.id/ragil/auth"; 

  RegisterService() {
    httpClient.baseUrl = baseUrlPath;
    httpClient.timeout = const Duration(seconds: 30);
  }

  Future<Response> registerUser(String fullName, String email, String password, String phoneNumber) async {
    try {
      final requestBody = {
        "fullName": fullName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
      };
      
      // Debug: Print URL dan request body
      print("📤 Register Request:");
      print("   URL: $baseUrlPath/register");
      print("   Method: POST");
      print("   Body: $requestBody");
      
      final response = await post(
        '/register',
        requestBody,
      );
      
      // Debug: Print response
      print("📥 Register Response:");
      print("   Status: ${response.statusCode}");
      print("   Body: ${response.body}");
      
      return response;
    } catch (e) {
      print("❌ API Register Error: $e");
      rethrow;
    }
  }
}