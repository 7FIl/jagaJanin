import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_jagajanin/App/Modules/details/controllers/detail_controllers.dart';

class Trimester3Kia extends StatefulWidget {
  const Trimester3Kia({super.key});

  @override
  State<Trimester3Kia> createState() => _Trimester3KiaState();
}

class _Trimester3KiaState extends State<Trimester3Kia> {
  late DetailController controller;

  @override
  void initState() {
    super.initState();

    // Get DetailController
    try {
      controller = Get.find<DetailController>();
      print('✅ Trimester3_KIA: DetailController ditemukan');
    } catch (e) {
      print('⚠️ Trimester3_KIA: DetailController tidak ditemukan, create fallback');
      controller = Get.put(DetailController(), permanent: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          final minggu = controller.detailData.value?.minggu ?? 28;
          final hpl = controller.detailData.value?.hpl ?? 'N/A';
          
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF48FB1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      'Trimester 3',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                      'HPL: $hpl',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}