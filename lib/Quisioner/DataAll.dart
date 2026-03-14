import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/Tools/KotakInfo.dart';
import 'package:flutter_jagajanin/Tools/Tombol_pink.dart';
import 'package:flutter_jagajanin/Home_page.dart';
import 'package:flutter_jagajanin/Unit/Home.dart';

class DataAll extends StatelessWidget {
  const DataAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/img/GambarYg.png'),
                    radius: 80,
                    backgroundColor: Colors.transparent,
                  ),
                ),

                const SizedBox(height: 20),
                const Center(
                  child: Column(
                    children: [
                      Text(
                        "Siap Melangkah, Bunda!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Data Bunda telah kami simpan dengan aman.",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Ringkasan Profil",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          KotakInfo(judul: "Nama", isi: null),
                          const SizedBox(width: 12), // Jarak antar kotak
                          KotakInfo(judul: "Usia", isi: null),
                        ],
                      ),
                      const SizedBox(height: 12), // Jarak baris atas dan bawah
                      const Row(
                        children: [
                          KotakInfo(
                            judul: "Usia Kehamilan",
                            isi: "Trimester 1",
                            warnaTeks: Colors.pinkAccent,
                          ),
                          const SizedBox(width: 12),
                          KotakInfo(
                            judul: "Aktivitas",
                            isi: "Sedang",
                            warnaTeks: Colors.pinkAccent,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24.0,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors
                              .pink
                              .shade50, // Latar belakang pink sangat muda
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.pink.shade100,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Ikon Sendok Garpu dalam lingkaran
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Color(0xFFE598AE), // Pink sedikit gelap
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.restaurant,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Teks Target Kalori
                            const Text(
                              'Target Kalori Harian',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Angka Kalori
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: const [
                                Text(
                                  '2.200',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'kkal',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Rincian Makanan (Nasi, Ayam, Sayur)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buatIkonMakanan(
                                  Icons.rice_bowl,
                                  'Nasi',
                                  '3 Centong',
                                ),
                                _buatIkonMakanan(
                                  Icons.lunch_dining,
                                  'Ayam',
                                  '3 Potong',
                                ), // Flutter tidak punya ikon paha ayam persis, ini alternatifnya
                                _buatIkonMakanan(
                                  Icons.eco,
                                  'Sayur',
                                  '3 Centong',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.info, color: Color(0xFFF48FB1), size: 15),
                          SizedBox(width: 10),
                          Text(
                            "Kami akan menyesuaikan saran nutrisi dan aktivitas \nsesuai dengan kebutuhan Trimester 1 Bunda.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Center(
                  child: ButtonPink(
                    Nama: "Masuk ke Dashboard",
                    onPressed: HomePage(),
                  ),
                ),
                
                SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ingin mengubah data? ",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Aksi untuk mengubah data (misalnya, kembali ke halaman sebelumnya)
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Kembali ke profil",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFF48FB1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buatIkonMakanan(IconData ikon, String nama, String porsi) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(ikon, color: const Color(0xFFE598AE), size: 28),
      ),
      const SizedBox(height: 8),
      Text(
        nama,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
      Text(porsi, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    ],
  );
}
