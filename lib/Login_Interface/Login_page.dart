import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/Login_Interface/SinginUp.dart';
import 'package:flutter_jagajanin/Quisioner/HalamanQuisioner.dart';
import 'package:flutter_jagajanin/Tools/TextField_interface.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
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
                          'Selamat Datang Kembali',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      new Center(
                        child: Text(
                          'Masuk untuk melanjutkan perjalanan Bunda',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  judulAtas: 'Email',
                  labelInput: 'Email',
                  hintInput: 'Masukkan email Anda',
                  controller: null,
                  textBelakang: null,
                  ikonKiri: Icons.email,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  judulAtas: 'Kata Sandi',
                  labelInput: 'Kata Sandi',
                  hintInput: 'Masukkan kata sandi Anda',
                  ikonKiri: Icons.lock,
                  controller: null,
                  textBelakang: null,
                  isPassword: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: const TextButton(
                    onPressed: null,
                    child: Text(
                      'Lupa Kata Sandi?',
                      style: TextStyle(fontSize: 15, color: Color(0xFFF48FB1)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => KuesionerHalaman()
                      ));
                      },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF48FB1),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Masuk',
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
                        'Belum punya akun?',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: const Text(
                          'Daftar di sini',
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
    );
  }
}
