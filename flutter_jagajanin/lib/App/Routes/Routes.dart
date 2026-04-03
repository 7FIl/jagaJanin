import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Modules/details/bindings/DetailBindings.dart';
import 'package:flutter_jagajanin/App/Modules/Login/Bindings/QuisionerBinding.dart';
import 'package:flutter_jagajanin/App/Modules/home/home_page.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Quisioner/HalamanQuisioner.dart';
import 'package:flutter_jagajanin/App/Modules/Login/Login_Interface/SinginUp.dart';
import 'package:flutter_jagajanin/App/Modules/Login/Login_Interface/Login_page.dart';
import 'package:flutter_jagajanin/App/Modules/home/KIA/trimester1_KIA.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Quisioner/DataAll.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Dashbord_unit/Food_Log.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static const INITIAL = '/login';

  static final routes = [
    GetPage(
      name: '/home',
      page: () => const HomePage(),
    ),
    GetPage(
      name: '/quisioner',
      page: () => const KuesionerHalaman(),
      binding: QuisionerBinding(),
    ),
    GetPage(
      name: '/signup',
      page: () => const Register(),
    ),
    GetPage(
      name: '/login',
      page: () => const Login(),
    ),
    GetPage(
    name: '/KIA1', 
    page: () => Trimester1Kia(),
    binding: DetailBinding(),
    ),
    GetPage(
      name: '/dataall', 
      page: () => const DataAll(),
      // Jangan gunakan binding lagi, controller sudah ada dari /quisioner
    ),
    GetPage(
      name: '/foodlog',
      page: () => const FoodLog(),
    ),
  ];
}





