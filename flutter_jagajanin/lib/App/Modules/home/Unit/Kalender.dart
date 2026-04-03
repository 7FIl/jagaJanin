import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Modules/details/controllers/detail_controllers.dart';
import 'package:flutter_jagajanin/App/Modules/home/KIA/trimester1_KIA.dart';
import 'package:flutter_jagajanin/App/Modules/home/KIA/trimester2_KIA.dart';
import 'package:flutter_jagajanin/App/Modules/home/KIA/trimester3_KIA.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class Kalender extends StatefulWidget {
  const Kalender({super.key});

  @override
  State<Kalender> createState() => _KalenderState();
}

class _KalenderState extends State<Kalender> {
  late DetailController controller;
  
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
  }
  @override
  Widget build(BuildContext context) {
      return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF48FB1)  ,
          toolbarHeight: 10,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            labelColor: Color(0xFFF48FB1),
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(child: Text('Trimester 1')),
              Tab(child: Text('Trimester 2')),
              Tab(child: Text('Trimester 3')),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Trimester1Kia(), 
            Trimester2Kia(), 
            Trimester3Kia()
            ],
        ),
      ),
    );
  }
}