import 'package:flutter/material.dart';
import 'package:jaga_janin_apk/Home_page.dart';
import 'package:jaga_janin_apk/Login_Interface/Login_page.dart';
import 'Home_page.dart';
import 'Button/Setting_Menu.dart';
import 'Login_Interface/SinginUp.dart';
import 'package:jaga_janin_apk/Quisioner/HalamanQuisioner.dart';
import 'package:jaga_janin_apk/Quisioner/DataAll.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
