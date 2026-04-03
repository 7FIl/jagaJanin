import 'package:get/get.dart';
import 'package:flutter_jagajanin/App/Modules/Login/Controller/QuisionerControllerForPage1.dart';

class QuisionerBinding extends Bindings {
  @override
  void dependencies() {
    print('>>> QuisionerBinding: dependencies() dipanggil');
    
    // Cek apakah controller sudah ada
    try {
      final existing = Get.find<QuisionerControllerForPage1>();
      print('>>> QuisionerBinding: Controller sudah ada! (reuse)');
      print('    Existing Controller HashCode: ${existing.hashCode}');
      print('    Data: Nama="${existing.namaPanggilanController.text}"');
      // Jangan buat yang baru, reuse yang sudah ada
      return;
    } catch (e) {
      // Controller belum ada, buat yang baru
      print('>>> QuisionerBinding: Controller belum ada, membuat yang baru');
    }
    
    // Buat dengan permanent: true agar controller SELALU tersedia
    // dan tidak di-dispose saat leave route
    Get.put<QuisionerControllerForPage1>(
      QuisionerControllerForPage1(), 
      permanent: true  // PENTING: Agar data tetap tersedia
    );
    
    final controller = Get.find<QuisionerControllerForPage1>();
    print('>>> QuisionerBinding: Controller baru dibuat');
    print('    New Controller HashCode: ${controller.hashCode}');
  }
}
