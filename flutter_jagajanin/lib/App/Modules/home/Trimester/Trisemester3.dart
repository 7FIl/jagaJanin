import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_jagajanin/App/Modules/details/controllers/detail_controllers.dart';

class Trisemester3 extends StatefulWidget {
  const Trisemester3({super.key});

  @override
  State<Trisemester3> createState() => _Trisemester3State();
}

class _Trisemester3State extends State<Trisemester3> {
  late DetailController detailController;

  @override
  void initState() {
    super.initState();
    
    // Get DetailController
    try {
      detailController = Get.find<DetailController>();
    } catch (e) {
      detailController = Get.put(DetailController(), permanent: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final minggu = detailController.detailData.value?.minggu ?? 28;
          return Text('Trimester 3 - Minggu ke-$minggu');
        }),
      ),
      body: Obx(() {
        final data = detailController.detailData.value;
        if (data == null) {
          return const Center(
            child: Text('Data tidak tersedia'),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Trimester 3 - Minggu ke-${data.minggu}'),
              const SizedBox(height: 10),
              Text('Trimester: ${data.trimester}'),
              const SizedBox(height: 10),
              Text('Progress: ${(data.progress ?? 0).toStringAsFixed(2)}'),
            ],
          ),
        );
      }),
    );
  }
}