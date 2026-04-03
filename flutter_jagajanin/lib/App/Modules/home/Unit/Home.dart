import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Modules/home/Trimester/Trisemester1.dart';
import 'package:flutter_jagajanin/App/Modules/home/Trimester/Trisemester2.dart';
import 'package:flutter_jagajanin/App/Modules/home/Trimester/Trisemester3.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
        body: const TabBarView(
          children: <Widget>[
            Trisemester1(), 
            Trisemester2(), 
            Trisemester3()
            ],
        ),
      ),
    );
  }
}
