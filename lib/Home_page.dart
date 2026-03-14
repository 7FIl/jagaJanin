import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/Unit/Home.dart';
import 'package:flutter_jagajanin/Unit/Kalender.dart';
import 'package:flutter_jagajanin/Unit/Chatbot.dart';
import 'package:flutter_jagajanin/Unit/Profil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int curretPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    late TabController control;
    NavigationDestinationLabelBehavior labelBehavior =
        NavigationDestinationLabelBehavior.onlyShowSelected;

    final List<Widget> pageList = [
      const Home(),
      const Kalender(),
      const Chatbot(),
      const Profil(),
    ];

    return Scaffold(

      body: pageList[curretPageIndex],

      bottomNavigationBar: SafeArea(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: NavigationBar(
            backgroundColor: const Color.fromARGB(255, 228, 221, 221),
            labelBehavior: labelBehavior,
            selectedIndex: curretPageIndex,
            onDestinationSelected: (int index) {
              setState(() {
                curretPageIndex = index;
              });
            },

            destinations: <Widget>[
              const NavigationDestination(
                selectedIcon: Icon(Icons.home_outlined),
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              NavigationDestination(
                selectedIcon: const Icon(Icons.calendar_month_outlined),
                icon: const Icon(Icons.calendar_month),
                label: 'KIA',
              ),
              const NavigationDestination(
                selectedIcon: Icon(Icons.adb),
                icon: Icon(Icons.chat),
                label: 'Chatbot',
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
