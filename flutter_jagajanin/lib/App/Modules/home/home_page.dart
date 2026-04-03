import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Modules/home/Unit/Home.dart';
import 'package:flutter_jagajanin/App/Modules/home/Unit/Kalender.dart';
import 'package:flutter_jagajanin/App/Modules/home/Unit/Profil.dart';
import 'package:flutter_jagajanin/App/Modules/home/Unit/konsultasi.dart';
import 'package:flutter_jagajanin/App/Modules/home/Controllers/KonsultasiController.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Dashbord_unit/FoodLogPage.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Dashbord_unit/CalorieDetailPage.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Models/food_model.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Controllers/FoodController.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  FoodController get foodController {
    if (!Get.isRegistered<FoodController>()) {
      Get.put(FoodController());
    }
    return Get.find<FoodController>();
  }

  @override
  void initState() {
    super.initState();
    // Initialize controllers early with lazyPut for better stability
    if (!Get.isRegistered<KonsultasiController>()) {
      Get.lazyPut<KonsultasiController>(() => KonsultasiController());
    }
    if (!Get.isRegistered<FoodController>()) {
      Get.put(FoodController());
    }
  }

  void _navigateToFoodLog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodLogPage(
          currentDayLog: foodController.currentDayLog,
          onFoodAdded: (food) {
            foodController.addFoodEntry(food);
          },
          onNavigateToDetail: _navigateToCalorieDetail,
        ),
      ),
    );
  }

  void _navigateToCalorieDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalorieDetailPage(
          weeklyLogs: foodController.weeklyLogs.value,
          onDateSelected: (date) {
            foodController.setSelectedDate(date);
          },
          onFoodAdded: (food) {
            foodController.addFoodEntry(food);
          },
          onFoodDeleted: (date, food) {
            foodController.deleteFoodEntry(date, food);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    NavigationDestinationLabelBehavior labelBehavior =
        NavigationDestinationLabelBehavior.alwaysShow;

    final List<Widget> pageList = [
      const Home(),
      const Kalender(),
      const Konsultasi(),
      const Profil(),
    ];

    return Scaffold(
      appBar: currentPageIndex != 3  // 3 = Profil
          ? AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.person_outline_rounded),
                    onPressed: () {
                      // Handle logout action
                    },
                  ),
                  const Text('Home Page'),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFFE594AB),
                    child: const Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: Colors.grey.shade300, 
                  height: 1.0, 
                ),
              ),
            )
          : null,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFFF48FB1),
        onPressed: () {
          _navigateToFoodLog();
        },
        child: const Icon(Icons.edit_note, color: Colors.white, size: 30),
      ),
      body: pageList[currentPageIndex],

      bottomNavigationBar: SafeArea(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: NavigationBar(
            backgroundColor: const Color.fromARGB(255, 240, 234, 234),
            labelBehavior: labelBehavior,
            selectedIndex: currentPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },

            destinations: <Widget>[
              const NavigationDestination(
                selectedIcon: Icon(Icons.home_outlined),
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              const NavigationDestination(
                selectedIcon: Icon(Icons.calendar_month_outlined),
                icon: Icon(Icons.calendar_month),
                label: 'KIA',
              ),
              NavigationDestination(
                selectedIcon: const Icon(Icons.medical_services_outlined),
                icon: FaIcon(
                  FontAwesomeIcons.stethoscope,
                  color: Colors.black,
                  size: 20,
                ),
                label: 'Konsultasi',
              ),
              const NavigationDestination(
                selectedIcon: Icon(Icons.account_circle_outlined),
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HalamanQuisioner {
  const HalamanQuisioner();
}
