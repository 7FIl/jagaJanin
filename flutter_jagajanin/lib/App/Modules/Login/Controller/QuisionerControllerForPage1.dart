import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuisionerControllerForPage1 extends GetxController {
  final namaPanggilanController = TextEditingController();
  final usiaController = TextEditingController();
  final tinggiController = TextEditingController();
  final beratController = TextEditingController();
  final usiaKehamilanController = TextEditingController();

  // Gunakan Rx untuk reactive variables
  RxString namaPanggilan = ''.obs;
  RxString usia = ''.obs;
  RxString tinggi = ''.obs;
  RxString berat = ''.obs;
  RxInt usiaKehamilan = 0.obs;
  RxString trimester = ''.obs;

  // Getter untuk akses sync data
  String getNamaPanggilan() => namaPanggilan.value;
  String getUsia() => usia.value;
  String getTinggi() => tinggi.value;
  String getBerat() => berat.value;
  int getUsiaKehamilan() => usiaKehamilan.value;
  String getTrimester() => trimester.value;

  void sinkronkanData() {
    print('=== SINKRONKAN DATA MULAI ===');
    print('Nama dari TextController: "${namaPanggilanController.text}"');
    print('Usia dari TextController: "${usiaController.text}"');
    print('Tinggi dari TextController: "${tinggiController.text}"');
    print('Berat dari TextController: "${beratController.text}"');
    print('Usia Kehamilan dari TextController: "${usiaKehamilanController.text}"');
    
    namaPanggilan.value = namaPanggilanController.text;
    usia.value = usiaController.text;
    tinggi.value = tinggiController.text;
    berat.value = beratController.text;
    usiaKehamilan.value = int.tryParse(usiaKehamilanController.text) ?? 0;

    trimester.value = usiaKehamilan.value <= 13
        ? "Trimester 1"
        : usiaKehamilan.value <= 26
            ? "Trimester 2"
            : "Trimester 3";
    
    print('Data setelah sinkronkan:');
    print('Nama: "${namaPanggilan.value}"');
    print('Usia: "${usia.value}"');
    print('Tinggi: "${tinggi.value}"');
    print('Berat: "${berat.value}"');
    print('Kehamilan: "${usiaKehamilan.value}"');
    print('Trimester: "${trimester.value}"');
    print('=== SINKRONKAN DATA SELESAI ===');
  }

  @override
  void onClose() {
    namaPanggilanController.dispose();
    usiaController.dispose();
    tinggiController.dispose();
    beratController.dispose();
    usiaKehamilanController.dispose();
    super.onClose();
  }
}