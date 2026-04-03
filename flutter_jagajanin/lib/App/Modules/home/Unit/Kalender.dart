import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_jagajanin/App/Modules/details/controllers/detail_controllers.dart';
import 'package:flutter_jagajanin/App/Modules/home/KIA/trimester1_KIA.dart';
import 'package:flutter_jagajanin/App/Modules/home/KIA/trimester2_KIA.dart';
import 'package:flutter_jagajanin/App/Modules/home/KIA/trimester3_KIA.dart';

class Kalender extends StatefulWidget {
  const Kalender({super.key});

  @override
  State<Kalender> createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> with SingleTickerProviderStateMixin {
  late DetailController controller;
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    
    // PENTING: Jangan use Get.put() - itu create instance BARU!
    // Gunakan Get.find() saja - DetailController sudah di-put di syncDetailData()
    try {
      controller = Get.find<DetailController>();
      print('>>> Kalender: DetailController found (hashCode: ${controller.hashCode})');
    } catch (e) {
      print('!!! Kalender: DetailController tidak ditemukan! Error: $e');
      // Fallback: create jika belum ada
      controller = Get.put(DetailController(), permanent: false);
      print('>>> Kalender: DetailController created as fallback');
    }
    print('>>> Kalender: detailData.value = ${controller.detailData.value}');

    // Set initial tab index berdasarkan trimester
    // Trimester 1 = index 0, Trimester 2 = index 1, Trimester 3 = index 2
    int initialIndex = 0;
    if (controller.detailData.value != null) {
      int trimester = controller.detailData.value?.trimester ?? 1;
      initialIndex = trimester - 1; // Convert 1-based ke 0-based index
      print('📅 Kalender: Trimester = $trimester, Initial Tab Index = $initialIndex');
    }

    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF48FB1),
        toolbarHeight: 10,
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          labelColor: const Color(0xFFF48FB1),
          unselectedLabelColor: Colors.white,
          tabs: const [
            Tab(child: Text('Trimester 1')),
            Tab(child: Text('Trimester 2')),
            Tab(child: Text('Trimester 3')),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Trimester1Kia(),
          Trimester2Kia(),
          Trimester3Kia(),
        ],
      ),
    );
  }
}