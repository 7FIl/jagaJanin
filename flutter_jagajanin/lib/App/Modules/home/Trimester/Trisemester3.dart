import 'package:flutter/material.dart';

class Trisemester3 extends StatefulWidget {
  const Trisemester3({super.key});

  @override
  State<Trisemester3> createState() => _Trisemester3State();
}

class _Trisemester3State extends State<Trisemester3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trimester 3'),
      ),
      body: const Center(
        child: Text('Content for Trimester 3'),
      ),
    );
  }
}