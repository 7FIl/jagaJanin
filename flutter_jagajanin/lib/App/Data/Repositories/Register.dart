import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<void> registerUser(BuildContext context, String name, String email, String password) async {
  // Gunakan IP 10.0.2.2 untuk emulator Android
  final url = Uri.parse('https://be-internship.bccdev.id/ragil/POST/auth/register'); 

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,       // Pastikan key ini sama dengan yang diminta backend
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
     
      print("Registrasi Berhasil!");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Akun berhasil dibuat! Silahkan Login.")),
      );
      Get.offNamed('/login'); // Kembali ke halaman login
    } else {
      print("Gagal Register: ${response.body}");
    }
  } catch (e) {
    print("Error koneksi: $e");
  }
}