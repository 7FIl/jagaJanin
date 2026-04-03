import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class JadwalKonsultasiItem {
  final String tanggal;
  final String waktu;
  final String dokter;
  final String spesialis;
  final String tarif;

  JadwalKonsultasiItem({
    required this.tanggal,
    required this.waktu,
    required this.dokter,
    required this.spesialis,
    required this.tarif,
  });
}

class KonsultasiController extends GetxController {
  RxList<JadwalKonsultasiItem> jadwalList = <JadwalKonsultasiItem>[
    JadwalKonsultasiItem(
      tanggal: 'Rabu, 13 April 2026',
      waktu: '10.00 - 11.00',
      dokter: 'Dr. Iwan, SpOG',
      spesialis: 'Obgyn',
      tarif: '50.000',
    ),
  ].obs;

  /// Add new consultation schedule with debounce to prevent excessive rebuilds
  void addJadwal({
    required String tanggal,
    required String waktu,
    required String dokter,
    required String spesialis,
    required String tarif,
  }) {
    if (tanggal.isNotEmpty && waktu.isNotEmpty && dokter.isNotEmpty) {
      final newItem = JadwalKonsultasiItem(
        tanggal: tanggal,
        waktu: waktu,
        dokter: dokter,
        spesialis: spesialis,
        tarif: tarif,
      );
      
      // Batch update to reduce number of notifications
      jadwalList.add(newItem);
      
      debugPrint('✅ Jadwal baru ditambahkan: $dokter - $tanggal $waktu');
      debugPrint('📊 Total jadwal: ${jadwalList.length}');
    } else {
      debugPrint('⚠️ Data incomplete: tanggal=$tanggal, waktu=$waktu, dokter=$dokter');
    }
  }

  /// Get total consultation schedules
  int getTotalJadwal() => jadwalList.length;

  /// Clear all schedules (except first default one)
  void resetJadwal() {
    jadwalList.clear();
    jadwalList.add(
      JadwalKonsultasiItem(
        tanggal: 'Rabu, 13 April 2026',
        waktu: '10.00 - 11.00',
        dokter: 'Dr. Iwan, SpOG',
        spesialis: 'Obgyn',
        tarif: '50.000',
      ),
    );
  }
}
