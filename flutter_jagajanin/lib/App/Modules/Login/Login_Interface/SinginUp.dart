import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Widget/Tools/TextField_interface.dart';
import 'package:flutter_jagajanin/App/Data/Repositories/Register.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Center(
                          child: Text(
                            'Jaga Janin',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF48FB1),
                            ),
                          ),
                        ),
                      ),

                      new Center(
                        child: Text(
                          'Buat Akun',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      new Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Bergabunglah dan pantau perjalanan \nkehamilan Bunda',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  judulAtas: 'Nama Lengkap Bunda', 
                  labelInput: 'Nama', 
                  hintInput: 'Nama Lengkap',
                  textBelakang: null,
                  ikonKiri: Icons.person,
                  controller: _nameController,
                  ),
                const SizedBox(height: 10),
                CustomTextField(
                  judulAtas: 'Email atau No. Handphone',
                  labelInput: 'Email',
                  hintInput: 'Masukkan email Anda',
                  textBelakang: null,
                  ikonKiri: Icons.email,
                  controller: _emailController,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  judulAtas: 'Kata Sandi',
                  labelInput: 'Kata Sandi',
                  hintInput: 'Masukkan kata sandi Anda',
                  textBelakang: null,
                  ikonKiri: Icons.lock,
                  isPassword: true,
                  controller: _passwordController,
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      registerUser(context, 
                      _nameController.text, 
                      _emailController.text,
                      _passwordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF48FB1),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Daftar Sekarang',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(color: Colors.grey, thickness: 1.0),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'atau',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),

                    const Expanded(
                      child: Divider(color: Colors.grey, thickness: 1.0),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    print('Proses login Google berjalan...');
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    side: const BorderSide(
                      color: Colors.pinkAccent,
                      width: 1.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/Google.png',
                        height: 24,
                        width: 24,
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        'Masuk dengan Google',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    children: [
                      SizedBox(width: 40),
                      const Text(
                        'Sudah punya akun?',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offNamed('/login');
                        },
                        child: const Text(
                          'Masuk di sini',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFF48FB1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}

