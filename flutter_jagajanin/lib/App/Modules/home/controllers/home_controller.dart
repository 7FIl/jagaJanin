import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Data/Models/Pregency_Models.dart';
import 'package:get/get.dart';
import 'package:flutter_jagajanin/App/Modules/Login/Controller/QuisionerControllerForPage1.dart';
import 'package:flutter_jagajanin/App/Modules/details/controllers/detail_controllers.dart';

// Fungsi untuk set data ke DetailController (tanpa navigasi)
PregnancyModel? _createPregnancyData() {
  try {
    final quisionerCtrl = Get.find<QuisionerControllerForPage1>();
    print('>>> _createPregnancyData(): QuisionerController ditemukan');
    
    // Gunakan data dari Rx variables yang sudah disinkronkan
    final minggu = quisionerCtrl.getUsiaKehamilan();
    final trimester = quisionerCtrl.getTrimester();
    
    print('>>> _createPregnancyData(): Data dari Rx');
    print('    Minggu: $minggu, Trimester: $trimester');
    
    // Validasi data
    if (minggu == 0 || trimester.isEmpty) {
      print('!!! _createPregnancyData(): Data kosong');
      Get.snackbar(
        'Data Tidak Lengkap',
        'Silakan isi ulang data kuisioner',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }
    
    // Hitung HPL dan progress
    final hariTersisa = 280 - (minggu * 7);
    
    // Hitung tanggal HPL (hari ini + hari tersisa)
    final tanggalHariIni = DateTime.now();
    final tanggalHPL = tanggalHariIni.add(Duration(days: hariTersisa));
    
    // Format HPL: "HPL 12 Juli 2026"
    final bulanIndonesia = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    final hplFormatted = 'HPL ${tanggalHPL.day} ${bulanIndonesia[tanggalHPL.month - 1]} ${tanggalHPL.year}';
    
    double progress = 0.0;
    if (trimester.contains('1')) {
      progress = (minggu / 13) * 3.33;
    } else if (trimester.contains('2')) {
      progress = 3.33 + ((minggu - 13) / 13) * 3.33;
    } else {
      progress = 6.66 + ((minggu - 26) / 14) * 3.34;
    }
    progress = progress.clamp(0.0, 10.0);
    progress = (progress * 10).ceil() / 10;

    final trimesterNum = int.tryParse(trimester.replaceAll(RegExp(r'[^0-9]'), '')) ?? 1;
    
    final data = PregnancyModel(
      minggu: minggu,
      hpl: hplFormatted,
      status: "Sehat",
      progress: progress,
      trimester: trimesterNum,
    );
    
    print('>>> _createPregnancyData(): PregnancyModel berhasil dibuat');
    print('    minggu: ${data.minggu}, trimester: ${data.trimester}');
    print('    HPL: ${data.hpl}');
    
    return data;
  } catch (e) {
    print('!!! _createPregnancyData(): ERROR - $e');
    return null;
  }
}

// Fungsi untuk set data ke DetailController (tanpa navigasi)
void syncDetailData() {
  print('>>> syncDetailData() dipanggil');
  
  try {
    final pregnancyData = _createPregnancyData();
    
    if (pregnancyData == null) {
      print('!!! syncDetailData(): Gagal membuat PregnancyData');
      return;
    }
    
    // PENTING: Register atau find DetailController
    // Gunakan permanent: true agar tidak di-destroy saat navigasi
    final detailCtrl = Get.isRegistered<DetailController>() 
      ? Get.find<DetailController>()
      : Get.put(DetailController(), permanent: true);
    
    // Set data langsung ke Rx variable
    detailCtrl.detailData.value = pregnancyData;
    print('>>> syncDetailData(): Data berhasil di-sync ke DetailController');
    print('    Controller hashCode: ${detailCtrl.hashCode}');
    print('    minggu: ${pregnancyData.minggu}, trimester: ${pregnancyData.trimester}');
    
  } catch (e) {
    print('!!! syncDetailData(): ERROR - $e');
  }
}

// Fungsi untuk navigate ke /KIA1 dengan data
void keDetail() {
  print('>>> keDetail() dipanggil');
  
  final pregnancyData = _createPregnancyData();
  if (pregnancyData == null) {
    print('!!! keDetail(): Gagal membuat PregnancyData');
    return;
  }
  
  print('>>> keDetail(): Navigate ke /KIA1 dengan arguments...');
  Get.toNamed('/KIA1', arguments: pregnancyData);
}
