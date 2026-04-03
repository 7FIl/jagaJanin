import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Modules/Login/Controller/QuisionerControllerForPage1.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Widget/Tools/TextField_interface.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class Halaman1 extends StatefulWidget {
  const Halaman1({super.key});

  @override
  State<Halaman1> createState() => _Halaman1State();
}

class _Halaman1State extends State<Halaman1> {
  late QuisionerControllerForPage1 c;

  @override
  void initState() {
    super.initState();
    // HANYA Find, jangan Put lagi (binding sudah handle Put)
    try {
      c = Get.find<QuisionerControllerForPage1>();
      print('>>> Halaman1 initState: Controller ditemukan');
      print('    Controller HashCode: ${c.hashCode}');
      print('    Nama Controller Text: "${c.namaPanggilanController.text}"');
      
      // Tambah listener untuk monitor perubahan data
      c.namaPanggilanController.addListener(() {
        print('>>> Halaman1 Listener: Nama berubah menjadi "${c.namaPanggilanController.text}"');
      });
      c.usiaController.addListener(() {
        print('>>> Halaman1 Listener: Usia berubah menjadi "${c.usiaController.text}"');
      });
      c.usiaKehamilanController.addListener(() {
        print('>>> Halaman1 Listener: Usia Kehamilan berubah menjadi "${c.usiaKehamilanController.text}"');
      });
      
    } catch (e) {
      print('!!! Halaman1 initState: Controller ERROR - $e');
      throw Exception('Controller tidak ditemukan! Pastikan QuisionerBinding sudah dijalankan');
    }
  }

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
                          controller: c.namaPanggilanController,
                          textBelakang: null,
                          ikonKiri: Icons.person,
                        ),

                        SizedBox(height: 10),
                        CustomTextField(
                          judulAtas: "Usia Bunda",
                          labelInput: null,
                          textBelakang: "Tahun",
                          hintInput: "Contoh: 28",
                          controller: c.usiaController,
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
                                controller: c. tinggiController,
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
                                controller: c.beratController,
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
                          controller: c.usiaKehamilanController,
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