import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_jagajanin/App/Data/Repositories/Login.dart';
import 'package:flutter_jagajanin/App/Data/Models/Pregency_Models.dart';
import 'package:flutter_jagajanin/App/Modules/details/controllers/detail_controllers.dart';

class AuthController extends GetxController {
  late AuthService _authService;
  var isLoading = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Akun fake untuk testing (sebelum backend siap)
  final Map<String, String> fakeAccounts = {
    'siti@example.com': 'rahasia123',
    'bunda@test.com': 'password123',
    'test@example.com': 'test123456',
  };

  @override
  void onInit() {
    super.onInit();
    _authService = AuthService();
    print("⚠️ === MODE TESTING: Menggunakan akun fake ===");
    print("📝 Akun yang tersedia:");
    fakeAccounts.forEach((email, password) {
      print("   Email: $email | Password: $password");
    });
  }

  // Validasi login dengan akun fake (local)
  bool validateLocalCredentials(String email, String password) {
    if (!fakeAccounts.containsKey(email)) {
      Get.snackbar("Gagal", "Email tidak terdaftar", 
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
      return false;
    }

    if (fakeAccounts[email] != password) {
      Get.snackbar("Gagal", "Password salah", 
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
      return false;
    }

    return true;
  }

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan password tidak boleh kosong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
      return;
    }

    isLoading.value = true;

    try {
      // TODO: Ganti dengan API call setelah backend siap
      // Untuk sekarang gunakan validasi local dengan akun fake
      
      print("🔐 Attempting login dengan akun fake...");
      
      if (validateLocalCredentials(email, password)) {
        // Login berhasil
        await Future.delayed(Duration(milliseconds: 500)); // Simulasi delay API
        
        print("✅ Login Sukses! (Testing Mode)");
        print("   Email: $email");

        // Buat dummy PregnancyModel untuk testing
        // CATATAN: Untuk akun fake, selalu ada data quisioner (tidak perlu hint ke halaman quisioner)
        final dummyPregnancyData = PregnancyModel(
          minggu: 20,
          hpl: '05 Oktober 2025',
          status: 'Kehamilan Normal',
          progress: 0.55,
          trimester: 2,
          nameFaskes: 'RSIA Bunda Jakarta',
          tenagaMedis: 'Dr. Sarah Aulia, SpOG',
          tanggalKontrol: '15 Maret 2026',
          tekananDarah: '110/70 mmHg',
          beratBadan: '68 kg',
          tinggiBadan: '165 cm',
          imt: '24.9',
          tinggiRahim: '18 cm',
          lingkarLenganAtas: '28 cm',
          hemoglobin: '12.4 g/dL',
          golonganDarah: 'O+',
          gulaDarah: '98 mg/dL',
          tesProteinUrine: 'Negatif(-)',
        );

        // Set ke DetailController
        try {
          final detailController = Get.find<DetailController>();
          detailController.detailData.value = dummyPregnancyData;
          print("✅ Dummy pregnancy data set to DetailController");
        } catch (e) {
          print("⚠️ DetailController tidak ditemukan, create baru");
          final detailController = Get.put(DetailController(), permanent: true);
          detailController.detailData.value = dummyPregnancyData;
        }

        // Clear controllers
        emailController.clear();
        passwordController.clear();

        // ⭐ LOGIC: Akun fake SELALU go to quisioner setiap login
        // Nanti untuk real accounts, check if quisioner data exists
        final isFakeAccount = fakeAccounts.containsKey(email);
        print("   IsFakeAccount: $isFakeAccount");

        if (isFakeAccount) {
          print("   Navigating to Quisioner (Fake Account)");
          Get.offAllNamed('/quisioner');
          Get.snackbar("Berhasil", "Selamat Datang, $email! 👋\n(Mode Testing - Ke Quisioner)", 
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.blue);
        } else {
          print("   Navigating to Home (Real Account)");
          Get.offAllNamed('/home');
          Get.snackbar("Berhasil", "Selamat Datang, $email! 👋", 
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green);
        }
      }
      
      
      // Uncomment dibawah ketika backend /auth/login sudah siap:
      /*
      final response = await _authService.loginUser(email, password);

      if (response.statusCode == 200) {
        var responseBody = response.body;
        String accessToken = responseBody['data']['accessToken'] ?? '';
        var userData = responseBody['data']['user'] ?? {};
        
        print("✅ Login Sukses!");
        print("   Access Token: $accessToken");
        print("   User: ${userData['fullName']}");

        emailController.clear();
        passwordController.clear();

        Get.offAllNamed('/home');
        Get.snackbar("Berhasil", "Selamat Datang, ${userData['fullName']}!", 
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green);
      } else if (response.statusCode == 401) {
        String message = response.body?['message'] ?? "Email atau password salah";
        print("❌ Login Gagal: $message");
        Get.snackbar("Gagal", message, 
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red);
      } else {
        String message = response.body?['message'] ?? "Login Gagal";
        print("❌ Login Gagal: $message (Status: ${response.statusCode})");
        Get.snackbar("Gagal", message, 
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red);
      }
      */
    } catch (e) {
      print("❌ Error: $e");
      Get.snackbar("Error", "Terjadi kesalahan: $e", 
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}