import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_jagajanin/App/Modules/details/controllers/detail_controllers.dart';

class Trisemester2 extends StatefulWidget {
  const Trisemester2({super.key});

  @override
  State<Trisemester2> createState() => _Trisemester2State();
}

class _Trisemester2State extends State<Trisemester2> {
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
          final minggu = detailController.detailData.value?.minggu ?? 13;
          return Text('Trimester 2 - Minggu ke-$minggu');
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
              Text('Trimester 2 - Minggu ke-${data.minggu}'),
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