import 'package:flutter/material.dart';
import 'Halaman1.dart';
import 'Halaman2.dart';
import 'Halaman3.dart';
import 'DataAll.dart';


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
                      child: const Text('KEMBALI', style: TextStyle(color: Colors.pinkAccent)),
                    )
                  else
                    const SizedBox(),

                  ElevatedButton(
                    onPressed: () {
                      if (halamanSekarang < daftarHalaman.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        ); // Efek transisi antar halaman
                      } else {
                        print('Selesai!');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DataAll(),
                          ),
                        ); // Navigasi ke halaman utama setelah selesai
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
