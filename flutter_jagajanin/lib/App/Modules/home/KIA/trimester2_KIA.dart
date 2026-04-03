import 'package:flutter/material.dart';

class Trimester2Kia extends StatefulWidget {
  const Trimester2Kia({super.key});

  @override
  State<Trimester2Kia> createState() => _Trimester2KiaState();
}

class _Trimester2KiaState extends State<Trimester2Kia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF48FB1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE497AA), // Warna pink background
                      borderRadius: BorderRadius.circular(20),
                      gradient: RadialGradient(
                        center: Alignment(
                          0.6,
                          -0.3,
                        ), // Sesuaikan pusat gradien (kanan agak atas)
                        radius: 1.5, // Atur seberapa luas gradien menyebar
                        colors: [
                          const Color(0xFFF48FB1), // Warna pink pusat
                          const Color(0xFFF48FB1), // Warna putih di pinggir
                        ],
                        stops: [
                          0.0,
                          1.0,
                        ], // Opsional: atur titik transisi warna
                      ),
                    ),

                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Teks di kiri
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Usia Kehamilan',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Text(
                                    '24 Minggu',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'Trimester 2 • HPL 12 Juli 2026',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
 
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Pemeriksaan Trimester 2',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '6/10 selesai',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: 0.6, // Nilai antara 0.0 dan 1.0 untuk menunjukkan kemajuan
                          backgroundColor: Colors.white, // Warna latar belakang
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.pink), // Warna indikator kemajuan
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}