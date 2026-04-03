import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_jagajanin/App/Data/Repositories/Register.dart';

class RegisterController extends GetxController {
  late RegisterService _registerService;
  var isLoading = false.obs;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Force create new instance untuk memastikan baseUrl up-to-date
    _registerService = RegisterService();
    print("✅ RegisterController initialized");
    print("   Service baseUrl: ${_registerService.httpClient.baseUrl}");
  }

  Future<void> register(String fullName, String email, String password, String phoneNumber) async {
    // Validasi input
    if (fullName.isEmpty || email.isEmpty || password.isEmpty || phoneNumber.isEmpty) {
      Get.snackbar("Error", "Semua field tidak boleh kosong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
      return;
    }

    if (password.length < 6) {
      Get.snackbar("Error", "Password minimal 6 karakter",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
      return;
    }

    // Validasi email format
    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Error", "Format email tidak valid",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
      return;
    }

    // Validasi nomor HP (minimal 10 digit)
    if (phoneNumber.length < 10) {
      Get.snackbar("Error", "Nomor HP minimal 10 digit",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
      return;
    }

    isLoading.value = true;

    try {
      // Menjalankan request ke API
      final response = await _registerService.registerUser(fullName, email, password, phoneNumber);

      if (response.statusCode == 201) {
        // Jika Register Berhasil (201 Created)
        var responseBody = response.body;
        var userData = responseBody['data'] ?? {};
        print("✅ Registrasi Berhasil!");
        print("   User ID: ${userData['id']}");
        print("   Nama: ${userData['fullName']}");
        print("   Email: ${userData['email']}");
        
        // Clear controllers
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        phoneController.clear();

        Get.snackbar("Berhasil", "Akun berhasil dibuat! Silahkan Login", 
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green);
        
        // Navigate ke login page
        await Future.delayed(Duration(seconds: 2));
        Get.offNamed('/login');
      } else if (response.statusCode == 409) {
        // Email sudah terdaftar
        String message = response.body?['message'] ?? "Email sudah terdaftar";
        print("❌ Email sudah dalam penggunaan (Status: ${response.statusCode})");
        Get.snackbar("Email Sudah Ada", message, 
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange);
      } else if (response.statusCode == 400) {
        // Bad Request - validasi field tidak sesuai
        String message = response.body?['message'] ?? "Data tidak valid";
        print("❌ Validasi Gagal: $message (Status: ${response.statusCode})");
        Get.snackbar("Data Tidak Valid", message, 
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red);
      } else {
        // Error lainnya
        String message = response.body?['message'] ?? "Registrasi Gagal";
        print("❌ Registrasi Gagal: $message (Status: ${response.statusCode})");
        Get.snackbar("Gagal", message, 
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red);
      }
    } catch (e) {
      // Jika terjadi error koneksi
      print("❌ Error: $e");
      Get.snackbar("Error", "Tidak dapat terhubung ke server: $e", 
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}