import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_jagajanin/App/Modules/details/controllers/detail_controllers.dart';
import 'package:flutter_jagajanin/App/Modules/home/Trimester/Trisemester1.dart';
import 'package:flutter_jagajanin/App/Modules/home/Trimester/Trisemester2.dart';
import 'package:flutter_jagajanin/App/Modules/home/Trimester/Trisemester3.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
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

    int initialIndex = 0;
    if (detailController.detailData.value != null) {
      int trimester = detailController.detailData.value?.trimester ?? 1;
      initialIndex = trimester - 1; 
      print('🏥 Home: Trimester = $trimester, Initial Tab Index = $initialIndex');
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
        children: const <Widget>[
          Trisemester1(),
          Trisemester2(),
          Trisemester3(),
        ],
      ),
    );
  }
}
