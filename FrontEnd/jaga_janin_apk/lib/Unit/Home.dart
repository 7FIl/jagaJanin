import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            IconButton(
              icon: const Icon(Icons.notifications_active_outlined),
              onPressed: () {
                // Handle logout action
              },
            ),
          ],
        ),
      ),
      
      body: const Center(
        child: Text('Welcome to the Home Page'),
      ),
    );
  }
}

