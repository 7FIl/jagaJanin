import 'package:flutter/material.dart';
import 'package:jaga_janin_apk/Tools/TextField_interface.dart';
import 'package:jaga_janin_apk/Tools/TextField_interface.dart';

class Halaman1 extends StatefulWidget {
  const Halaman1({super.key});

  @override
  State<Halaman1> createState() => _Halaman1State();
}

class _Halaman1State extends State<Halaman1> {
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
                        SizedBox(height: 10),
                        new Center(
                          child: Text(
                            'Selamat Datang di Jaga Janin',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(height: 8),
                        CustomTextField(
                          judulAtas: "Nama Panggilan",
                          labelInput: null,
                          hintInput: "Masukkan nama panggilan Bunda",
                          controller: null,
                          textBelakang: null,
                          ikonKiri: Icons.person,
                        ),

                        SizedBox(height: 10),
                        CustomTextField(
                          judulAtas: "Usia Bunda",
                          labelInput: null,
                          textBelakang: "Tahun",
                          hintInput: "Contoh: 28",
                          controller: null,
                          ikonKiri: Icons.person,
                        ),

                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                judulAtas: "Tinggi Badan",
                                labelInput: null,
                                textBelakang: "cm",
                                hintInput: "160",
                                controller: null,
                                ikonKiri: Icons.straighten,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: CustomTextField(
                                judulAtas: "Berat Badan",
                                labelInput: null,
                                textBelakang: "kg",
                                hintInput: "55",
                                controller: null,
                                ikonKiri: Icons.monitor_weight,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),
                        CustomTextField(
                          judulAtas: "Usia Kehamilan",
                          labelInput: null,
                          textBelakang: "Minggu",
                          hintInput: "Contoh: 2",
                          controller: null,
                          ikonKiri: Icons.pregnant_woman_rounded,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}