import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Widget/Dialog/PilihJadwalKonsultasiDialog.dart';
import 'package:flutter_jagajanin/App/Modules/home/Unit/konsultasi.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ProfilDokter extends StatelessWidget {
  final String gambar;
  final String nama;
  final String spesialis;
  final String pengalaman;
  final String rumahSakit;
  final String tarif;
  final String? hari1;
  final String? hari2;
  final String? hari3;
  final String? waktu1;
  final String? waktu2;
  final String? waktu3;
  final String? kondisi1;
  final String? kondisi2;
  final String? kondisi3;

  const ProfilDokter({
    super.key,
    required this.gambar,
    required this.nama,
    required this.spesialis,
    required this.pengalaman,
    required this.tarif,
    this.hari1,
    this.hari2,
    this.hari3,
    this.waktu1,
    this.waktu2,
    this.waktu3,
    this.kondisi1,
    this.kondisi2,
    this.kondisi3,
    required this.rumahSakit,
  });

  final Color primaryPink = const Color(0xFFE594AB);
  final Color lightPinkBg = const Color(0xFFFCE4EC);
  final Color borderColor = const Color(0xFFFFD1DC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black54),
        title: const Text(
          'Profil Dokter',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("${gambar}"),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "$nama",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$spesialis',
                      style: TextStyle(fontSize: 18, color: primaryPink),
                    ),
                    Text(
                      '$rumahSakit • $pengalaman Tahun Pengalaman',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Row Pasien & Rating
              Row(
                children: [
                  _buildStatCard('Pasien', '500+'),
                  const SizedBox(width: 16),
                  _buildStatCard('Rating', '4.9', isRating: true),
                ],
              ),
              const SizedBox(height: 24),

              // 3. Tentang Dokter
              _buildSectionTitle(Icons.info_outline, 'Tentang Dokter'),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Lorem ipsum dolor sit amet consectetur. Senectus euismod sit ut placerat facilisi neque amet eleifend viverra...',
                  style: TextStyle(color: Colors.grey, height: 1.5),
                ),
              ),
              const SizedBox(height: 24),

              // 4. Jadwal Praktik
              _buildSectionTitle(
                Icons.calendar_month_outlined,
                'Jadwal Praktik',
              ),
              const SizedBox(height: 12),
              _buildScheduleCard('$hari1', '$kondisi1', '$waktu1'),
              const SizedBox(height: 12),
              _buildScheduleCard('$hari2', '$kondisi2', '$waktu2'),
              const SizedBox(height: 12),
              _buildScheduleCard('$hari3', '$kondisi3', '$waktu3'),
              const SizedBox(height: 24),

              // 5. Harga Konsultasi
              _buildSectionTitle(Icons.payments_outlined, 'Harga Konsultasi'),
              const SizedBox(height: 12),
              _buildPriceCard('$tarif'),
              const SizedBox(height: 32),

              // 6. Tombol Pilih Jadwal
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => PilihJadwalKonsultasiDialog(
                        nama: nama,
                        spesialis: spesialis,
                        tarif: tarif,
                        hari1: hari1 ?? 'Senin',
                        waktu1: waktu1 ?? '09.00 - 12.00',
                        kondisi1: kondisi1 ?? 'Konsultasi',
                        hari2: hari2,
                        waktu2: waktu2,
                        kondisi2: kondisi2,
                        hari3: hari3,
                        waktu3: waktu3,
                        kondisi3: kondisi3,
                        onConfirm: (tanggal, waktu) {
                          // Navigate to konsultasi with data
                          Get.to(
                            () => const Konsultasi(),
                            arguments: {
                              'tanggal': tanggal,
                              'waktu': waktu,
                              'dokter': nama,
                              'spesialis': spesialis,
                              'tarif': tarif,
                            },
                          );
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Pilih Jadwal Konsultasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildStatCard(String title, String value, {bool isRating = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isRating)
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: primaryPink, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildScheduleCard(String days, String session, String time) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                days,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(session, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          Text(
            time,
            style: TextStyle(color: primaryPink, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCard(String price) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: borderColor,
          style: BorderStyle.solid,
        ), // Gunakan dashed jika pakai package tambahan
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: lightPinkBg,
            child: Icon(Icons.chat_bubble_outline, color: primaryPink),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Per sesi', style: TextStyle(color: Colors.grey)),
              Text(
                '$price',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DoctorProfilePage {}
