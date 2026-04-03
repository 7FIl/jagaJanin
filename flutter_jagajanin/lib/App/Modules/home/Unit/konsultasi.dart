import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Widget/Card/jadwalKonsultasiCard.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Widget/Card/DokterCard.dart';
import 'package:flutter_jagajanin/App/Modules/home/Controllers/KonsultasiController.dart';
import 'package:get/get.dart';

class Konsultasi extends StatelessWidget {
  const Konsultasi({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
              SizedBox(height: 20),
              Text(
                "Temukan dokter untuk konsultasi kesehatan kehamilan",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Dokter Spesialis',
                    hintStyle: const TextStyle(
                      color: Color(0xFF7E8CA0),
                      fontSize: 16,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF7E8CA0),
                      size: 25,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Jadwal Konsultasi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    if (Get.isRegistered<KonsultasiController>())
                      Obx(
                        () {
                          final controller = Get.find<KonsultasiController>();
                          return controller.jadwalList.isNotEmpty
                              ? Text(
                                  'Lihat semua',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFE594AB),
                                  ),
                                )
                              : const SizedBox.shrink();
                        },
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Display all scheduled consultations
              if (Get.isRegistered<KonsultasiController>())
                Obx(
                  () {
                    final controller = Get.find<KonsultasiController>();
                    final isEmpty = controller.jadwalList.isEmpty;
                    return isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Belum ada jadwal konsultasi',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.jadwalList.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final jadwal = controller.jadwalList[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: JadwalKonsultasiCard(
                                  tanggal: jadwal.tanggal,
                                  dokter: jadwal.dokter,
                                ),
                              );
                            },
                          );
                  },
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Memuat...',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Rekomendasi Dokter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    Text(
                      'Lihat semua',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFE594AB), // Warna pink
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              DoctorCard(
                nama: 'Dr. Iwan, SpOG',
                spesialis: 'Obgyn',
                pengalaman: '12',
                tarif: '50.000',
                fotoUrl: 'assets/img/Dokter.png',
                rumahSakit: 'RSIA Bunda Jakarta',
                hari1: 'Senin',
                kondisi1: 'Konsultasi Online',
                waktu1: '09.00 - 12.00',
                hari2: 'Rabu',
                kondisi2: 'Pagi',
                waktu2: '14.00 - 17.00',
                hari3: 'Jumat',
                kondisi3: 'Konsultasi Online',
                waktu3: '09.00 - 12.00',
              ),
              SizedBox(height: 16),
              DoctorCard(
                nama: 'Dr. Siti, SpOG',
                spesialis: 'Obgyn',
                pengalaman: '8',
                tarif: '45.000',
                fotoUrl: 'assets/img/Dokter2.png',
                rumahSakit: 'RSIA Bunda Jakarta',
                hari1: 'Selasa',
                kondisi1: 'Malam',
                waktu1: '18.00 - 21.00',
                hari2: 'Kamis',
                kondisi2: 'Konsultasi Online',
                waktu2: '09.00 - 12.00',
                hari3: 'Sabtu',
                kondisi3: 'Pagi',
                waktu3: '09.00 - 12.00',
              ),
              SizedBox(height: 150),
            ],
          ),
        );
  }
}