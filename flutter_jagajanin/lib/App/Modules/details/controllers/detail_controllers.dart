import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Data/Models/Pregency_Models.dart';
import 'package:flutter_jagajanin/App/Modules/Login/Controller/QuisionerControllerForPage1.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final detailData = Rxn<PregnancyModel>();

  @override
  void onInit() {
    super.onInit();

    print('>>> DetailController onInit() dipanggil');
    print('    Get.arguments: ${Get.arguments}');
    print('    detailData.value sudah ada? ${detailData.value != null}');

    // Handle Get.arguments jika ada
    if (Get.arguments != null) {
      try {
        detailData.value = Get.arguments as PregnancyModel;
        print('>>> DetailController: Data dari Get.arguments berhasil di-set');
      } catch (e) {
        print('!!! DetailController: Error casting arguments - $e');
      }
    }

    // Tambahkan listener untuk mengisi data Quisioner ketika detailData tersedia
    // Gunakan ever() untuk menjalankan setiap kali detailData berubah
    ever(detailData, (PregnancyModel? data) {
      if (data != null) {
        print('>>> DetailController ever() listener: detailData tersedia');
        print('    minggu: ${data.minggu}');
        print('    trimester: ${data.trimester}');
        
        // Coba ambil data dari Quisioner
        try {
          final quisionerController = Get.find<QuisionerControllerForPage1>();
          
          // Coba ambil dari TextEditingController terlebih dahulu (lebih reliable)
          String tinggiValue = quisionerController.tinggiController.text.trim();
          String beratValue = quisionerController.beratController.text.trim();
          
          // Jika kosong, coba ambil dari observable
          if (tinggiValue.isEmpty) {
            tinggiValue = quisionerController.getTinggi().trim();
          }
          if (beratValue.isEmpty) {
            beratValue = quisionerController.getBerat().trim();
          }
          
          print('>>> DetailController: Data dari Quisioner (RxListener)');
          print('    Tinggi Controller Text: "${quisionerController.tinggiController.text}"');
          print('    Berat Controller Text: "${quisionerController.beratController.text}"');
          print('    Tinggi Getter: "${quisionerController.getTinggi()}"');
          print('    Berat Getter: "${quisionerController.getBerat()}"');
          
          bool updated = false;
          
          // Set tinggi badan jika nilai ditemukan dan field masih kosong/null
          if (tinggiValue.isNotEmpty && (data.tinggiBadan == null || data.tinggiBadan!.isEmpty)) {
            data.tinggiBadan = tinggiValue;
            print('>>> DetailController: Tinggi Badan di-set: $tinggiValue cm');
            updated = true;
          }
          
          // Set berat badan jika nilai ditemukan dan field masih kosong/null
          if (beratValue.isNotEmpty && (data.beratBadan == null || data.beratBadan!.isEmpty)) {
            data.beratBadan = beratValue;
            print('>>> DetailController: Berat Badan di-set: $beratValue kg');
            updated = true;
          }
          
          // Refresh jika ada perubahan
          if (updated) {
            detailData.refresh();
            print('>>> DetailController: detailData di-refresh');
          }
        } catch (e) {
          print('!!! DetailController: Gagal mengambil data Quisioner di listener - $e');
        }
      }
    });
  }
}
