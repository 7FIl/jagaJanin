import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'Halaman1.dart';
import 'Halaman2.dart';
import 'Halaman3.dart';
import 'DataAll.dart';
import 'package:flutter_jagajanin/App/Modules/Login/Controller/QuisionerControllerForPage1.dart';

class KuesionerHalaman extends StatefulWidget {
  const KuesionerHalaman({super.key});

  @override
  State<KuesionerHalaman> createState() => KuesionerHalamanState();
}

class KuesionerHalamanState extends State<KuesionerHalaman> {
  final PageController _pageController = PageController();
  int halamanSekarang = 0;

  final List<Widget> daftarHalaman = [
    const Halaman1(), // Tampilan halaman 1
    const Halaman2(), // Tampilan halaman 2
    const Halaman3(), // Tampilan halaman 3
  ];

  // Panggil ini untuk sinkronkan data sebelum navigate
  void sinkronkanDataDariController() {
    print('\n>>> SINKRONKAN DATA: Memulai proses...');
    try {
      final controller = Get.find<QuisionerControllerForPage1>();
      print('>>> SINKRONKAN DATA: Controller ditemukan');
      print('    Controller HashCode: ${controller.hashCode}');
      print('    Controller MemoryAddress: ${controller.toString()}');
      
      // Debug: Cek data di TextEditingController sebelum sinkronkan
      print('\n=== DATA DI TEXTCONTROLLER (SEBELUM SINKRONKAN) ===');
      print('  Nama: "${controller.namaPanggilanController.text}"');
      print('  Usia: "${controller.usiaController.text}"');
      print('  Tinggi: "${controller.tinggiController.text}"');
      print('  Berat: "${controller.beratController.text}"');
      print('  Usia Kehamilan: "${controller.usiaKehamilanController.text}"');
      print('  TextController Instances:');
      print('    Nama Controller: ${controller.namaPanggilanController.hashCode}');
      print('    Usia Controller: ${controller.usiaController.hashCode}');
      print('    Kehamilan Controller: ${controller.usiaKehamilanController.hashCode}');
      print('=========================================\n');
      
      // Sinkronkan dalam kondisi apapun
      controller.sinkronkanData();
      
      print('\n=== DATA DI RX VARIABLES (SETELAH SINKRONKAN) ===');
      print('  Nama: "${controller.getNamaPanggilan()}"');
      print('  Usia: "${controller.getUsia()}"');
      print('  Tinggi: "${controller.getTinggi()}"');
      print('  Berat: "${controller.getBerat()}"');
      print('  Usia Kehamilan: "${controller.getUsiaKehamilan()}"');
      print('  Trimester: "${controller.getTrimester()}"');
      print('  Rx Variables:');
      print('    namaPanggilan.value: "${controller.namaPanggilan.value}"');
      print('    usia.value: "${controller.usia.value}"');
      print('    usiaKehamilan.value: "${controller.usiaKehamilan.value}"');
      print('    trimester.value: "${controller.trimester.value}"');
      print('=========================================\n');
      
      print('>>> SINKRONKAN DATA: Berhasil!');
    } catch (e) {
      print('!!! SINKRONKAN DATA: Error - $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            Text(
              "Kuisioner \nPra-Pendaftaran",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF48FB1),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Progres Anda",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Tahap ${halamanSekarang + 1} dari ${daftarHalaman.length}",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                left: 20,
                right: 20,
              ),
              child: LinearProgressIndicator(
                value: (halamanSekarang + 1) / daftarHalaman.length,
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: Colors.grey[200],
                color: Colors.pinkAccent,
              ),
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int index) {
                  setState(() {
                    halamanSekarang = index;
                  });
                },
                children: daftarHalaman,
              ),
            ),

            // --- TOMBOL NAVIGASI ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (halamanSekarang > 0)
                    TextButton(
                      onPressed: () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                      child: const Text(
                        'KEMBALI',
                        style: TextStyle(color: Colors.pinkAccent),
                      ),
                    )
                  else
                    const SizedBox(),

                  ElevatedButton(
                    onPressed: () {
                      if (halamanSekarang < daftarHalaman.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      } else {
                        // Sinkronkan data sebelum navigate ke DataAll
                        print('>>> Tombol SELESAI ditekan');
                        print('>>> Halaman sekarang: $halamanSekarang');
                        sinkronkanDataDariController();
                        
                        // Delay kecil untuk memastikan data tersinkronkan
                        Future.delayed(Duration(milliseconds: 200), () {
                          print('>>> Navigasi ke /dataall');
                          Get.offNamed('/dataall');
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      halamanSekarang == daftarHalaman.length - 1
                          ? 'SELESAI'
                          : 'LANJUT',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
