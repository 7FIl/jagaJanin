import 'package:flutter/material.dart';

class Trisemester2 extends StatefulWidget {
  const Trisemester2({super.key});

  @override
  State<Trisemester2> createState() => _Trisemester2State();
}

class _Trisemester2State extends State<Trisemester2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trimester 2'),
      ),
      body: const Center(
        child: Text('Content for Trimester 2'),
      ),
    );
  }
}