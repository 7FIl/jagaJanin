import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_jagajanin/App/Modules/details/controllers/detail_controllers.dart';

class Trimester2Kia extends StatefulWidget {
  const Trimester2Kia({super.key});

  @override
  State<Trimester2Kia> createState() => _Trimester2KiaState();
}

class _Trimester2KiaState extends State<Trimester2Kia> {
  late DetailController controller;

  @override
  void initState() {
    super.initState();

    // Get DetailController
    try {
      controller = Get.find<DetailController>();
      print('✅ Trimester2_KIA: DetailController ditemukan');
    } catch (e) {
      print('⚠️ Trimester2_KIA: DetailController tidak ditemukan, create fallback');
      controller = Get.put(DetailController(), permanent: false);
    }
  }
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
                                  Obx(() {
                                    final minggu = controller.detailData.value?.minggu ?? 24;
                                    final hpl = controller.detailData.value?.hpl ?? '12 Juli 2026';
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$minggu Minggu',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Trimester 2 • HPL $hpl',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
 
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