import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Widget/Button/DoctorProfil.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Widget/Dialog/PilihJadwalKonsultasiDialog.dart';
import 'package:flutter_jagajanin/App/Modules/home/Controllers/KonsultasiController.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class DoctorCard extends StatelessWidget {
  final String nama;
  final String spesialis;
  final String pengalaman;
  final String tarif;
  final String fotoUrl;
  final String rumahSakit;
  final String? hari1;
  final String? hari2;
  final String? hari3;
  final String? waktu1;
  final String? waktu2;
  final String? waktu3;
  final String? kondisi1;
  final String? kondisi2;
  final String? kondisi3;

  const DoctorCard({
    super.key,
    required this.nama,
    required this.spesialis,
    required this.pengalaman,
    required this.tarif,
    required this.fotoUrl,
    required this.rumahSakit,
    this.hari1,
    this.hari2,
    this.hari3,
    this.waktu1,
    this.waktu2,
    this.waktu3,
    this.kondisi1,
    this.kondisi2,
    this.kondisi3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFFFD1DC), width: 1.5),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Foto Dokter (Kotak Melengkung)
                Container(
                  width: 90,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage('$fotoUrl'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Informasi Dokter
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$nama',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                          // Rating Bintang
                          Row(
                            children: const [
                              Icon(Icons.star, color: Colors.amber, size: 14),
                              SizedBox(width: 4),
                              Text(
                                '4.9',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.amber,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 14),
                      Text(
                        'Spesialis ${spesialis} • ${pengalaman} tahun',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rp ${tarif}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Tombol Aksi
            Row(
              children: [
                // Tombol Lihat Profil (Outline)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.to(() => ProfilDokter(
                            nama: nama,
                            spesialis: spesialis,
                            pengalaman: pengalaman,
                            tarif: tarif,
                            gambar: fotoUrl,
                            rumahSakit: rumahSakit,
                            hari1: hari1,
                            kondisi1: kondisi1,
                            waktu1: waktu1,
                            hari2: hari2,
                            kondisi2: kondisi2,
                            waktu2: waktu2,
                            hari3: hari3,
                            kondisi3: kondisi3,
                            waktu3: waktu3,
                          ));
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(
                        color: Color(0xFFFFD1DC),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Lihat Profil',
                      style: TextStyle(
                        color: Color(0xFFE594AB),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Tombol Konsultasi (Filled)
                Expanded(
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
                            // Close the dialog - will provide context automatically
                            Navigator.pop(context);
                            
                            // Defer to next frame to let dialog close animation complete
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              Future.delayed(const Duration(milliseconds: 300), () {
                                // Ensure controller exists
                                if (!Get.isRegistered<KonsultasiController>()) {
                                  Get.lazyPut<KonsultasiController>(() => KonsultasiController());
                                }
                                
                                // Add the consultation schedule
                                final controller = Get.find<KonsultasiController>();
                                controller.addJadwal(
                                  tanggal: tanggal,
                                  waktu: waktu,
                                  dokter: nama,
                                  spesialis: spesialis,
                                  tarif: tarif,
                                );
                                
                                debugPrint('✅ Jadwal konsultasi ditambahkan: $nama');
                              });
                            });
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE594AB),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Konsultasi',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
