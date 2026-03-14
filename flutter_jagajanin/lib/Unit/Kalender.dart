import 'package:flutter/material.dart';

class Kalender extends StatefulWidget {
  const Kalender({super.key});

  @override
  State<Kalender> createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: const Center(
          child: Text('Welcome to the Kalender Page'),
        ),
      );
  }
}