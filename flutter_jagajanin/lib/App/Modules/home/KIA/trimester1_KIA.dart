import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Modules/details/controllers/detail_controllers.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/state_manager.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Widget/Card/cek_list_item.dart'
    as cek_list;
import 'package:flutter_jagajanin/App/Modules/Login/View/Widget/Card/LabRow.dart';
import 'Widget/index.dart';
import 'Widget/Tools/edit_lab_dialog.dart';
import 'Widget/Tools/edit_hpht_dialog.dart';

class Trimester1Kia extends StatefulWidget {
  Trimester1Kia({super.key});

  @override
  State<Trimester1Kia> createState() => _Trimester1KiaState();
}

class _Trimester1KiaState extends State<Trimester1Kia> {
  late DetailController controller;
  late Map<String, bool> checklistStatus;

  @override
  void initState() {
    super.initState();
    
    // Coba ambil DetailController, jika tidak ada buat fallback
    try {
      controller = Get.find<DetailController>();
      print('✅ Trimester1_KIA: DetailController ditemukan');
    } catch (e) {
      print('⚠️ Trimester1_KIA: DetailController tidak ditemukan, create fallback');
      controller = Get.put(DetailController(), permanent: false);
    }
    
    // Inisialisasi checklist status
    final items = [
      "Letak & Denyut Jantung Janin",
      "Konseling",
      "Imunisasi Tetanus",
      "Skrinning Kesehatan",
      "Tablet Tambah Darah",
      "PPIA",
    ];
    checklistStatus = {for (var item in items) item: false};
  }

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      "Letak & Denyut Jantung Janin",
      "Konseling",
      "Imunisasi Tetanus",
      "Skrinning Kesehatan",
      "Tablet Tambah Darah",
      "PPIA",
    ];

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Obx(() {
              final data = controller.detailData.value;

              if (data == null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline, size: 50, color: Colors.grey),
                        SizedBox(height: 20),
                        Text(
                          "Data Kehamilan Tidak Tersedia",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Silakan isi data di halaman Quisioner terlebih dahulu.",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => Get.toNamed('/quisioner'),
                          child: Text("Isi Data Quisioner"),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF48FB1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFE497AA,
                          ), // Warna pink background
                          borderRadius: BorderRadius.circular(20),
                          gradient: RadialGradient(
                            center: Alignment(
                              0.6,
                              -0.3,
                            ), // Sesuaikan pusat gradien (kanan agak atas)
                            radius: 1.5, // Atur seberapa luas gradien menyebar
                            colors: [
                              const Color(0xFFF48FB1), // Warna pink pusat
                              const Color(0xFFF48FB1), // Warna putih di pinggir
                            ],
                            stops: [
                              0.0,
                              1.0,
                            ], // Opsional: atur titik transisi warna
                          ),
                        ),

                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Teks di kiri
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Usia Kehamilan',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "${data.minggu} Minggu",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Trimester ${data.trimester} • ${data.hpl}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),

                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Pemeriksaan Trimester ${data.trimester}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            '${data.progress}/10 selesai',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            LinearProgressIndicator(
                              value:
                                  (controller.detailData.value?.progress ?? 0) /
                                  10,
                              backgroundColor:
                                  Colors.white, // Warna latar belakang
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.pink,
                              ), // Warna indikator kemajuan
                            ),

                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: 350,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Color(0xFFFCE4EC),
                          width: 2,
                        ), // Warna border pink muda
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header: Ikon dan Judul
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF06292).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.location_city,
                                  color: Color(0xFFF06292),
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Tempat Pemeriksaan',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),

                          // Detail Fasilitas Kesehatan
                          Text(
                            'Nama Faskes',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            data.nameFaskes ?? 'RSIA Bunda',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tenaga Medis',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    data.tenagaMedis ?? 'Dr. Sarah Aulia',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tanggal Kontrol',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    data.tanggalKontrol ?? '15 Maret 2026',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 24),

                          // Tombol Ubah Detail
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                EditDetailDialog.show(
                                  context,
                                  data,
                                  onSave: (nameFaskes, tenagaMedis, tanggalKontrol) {
                                    _updateDetailData(
                                      nameFaskes,
                                      tenagaMedis,
                                      tanggalKontrol,
                                    );
                                  },
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Color(0xFFFCE4EC)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Text(
                                'Ubah Detail',
                                style: TextStyle(
                                  color: Color(0xFFF06292),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Judul Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pemeriksaan Fisik",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.edit_outlined, color: Color(0xFFF06292)),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),

                      // Grid Card
                      GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        childAspectRatio: 1.8,
                        children: [
                          buildInfoCard("Tekanan Darah", _formatValue(data.tekananDarah), "mm/hg"),
                          buildInfoCard("Berat Badan", _formatValue(data.beratBadan), "kg"),
                          buildInfoCard("Tinggi Badan", _formatValue(data.tinggiBadan), "cm"),
                          buildInfoCard("IMT", _formatValue(data.imt), "normal"),
                          buildInfoCard("Tinggi Rahim", _formatValue(data.tinggiRahim), "cm"),
                          buildInfoCard("Lingkar Lengan Atas", _formatValue(data.lingkarLenganAtas), "cm"),
                        ],
                      ),
                      SizedBox(height: 10),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              EditPhysicalExamDialog.show(
                                context,
                                data,
                                onSave: (tekananDarah, beratBadan, tinggiBadan, imt, tinggiRahim, lingkarLenganAtas) {
                                  _updatePhysicalExamData(
                                    tekananDarah,
                                    beratBadan,
                                    tinggiBadan,
                                    imt,
                                    tinggiRahim,
                                    lingkarLenganAtas,
                                  );
                                },
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Color(0xFFFCE4EC)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'Ubah Data',
                              style: TextStyle(
                                color: Color(0xFFF06292),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Color(0xFFFCE4EC),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Header
                              Row(
                                children: [
                                  Icon(
                                    Icons.assignment_outlined,
                                    color: Color(0xFFF06292),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Checklist Kehamilan',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),

                              // Daftar Item
                              Column(
                                children: items
                                    .map((item) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: cek_list.buildChecklistItem(
                                        item,
                                        checklistStatus[item] ?? false,
                                        () {
                                          setState(() {
                                            checklistStatus[item] = !(checklistStatus[item] ?? false);
                                          });
                                        },
                                      ),
                                    ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Color(0xFFFCE4EC),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Header
                              Row(
                                children: [
                                  Icon(
                                    Icons.science_outlined,
                                    color: Color(0xFFF06292),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Tes Lab',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),

                              // Daftar Hasil Tes
                              buildLabRow("Hemoglobin (Hb)", _formatValue(data.hemoglobin), " g/dL"),
                              buildLabRow("Tes Golongan Darah", _formatValue(data.golonganDarah), ""),
                              buildLabRow("Gula Darah", _formatValue(data.gulaDarah), " mg/dL"),

                              // Khusus untuk Protein Urine dengan Background Hijau
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Tes Protein Urine",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getProteinUrineColor(data.tesProteinUrine),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        data.tesProteinUrine ?? "Negatif (-)",
                                        style: TextStyle(
                                          color: _getProteinUrineTextColor(data.tesProteinUrine),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 20),

                              // Tombol Ubah Detail
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () {
                                    EditLabDialog.show(
                                      context,
                                      data,
                                      onSave: (hemoglobin, golonganDarah, gulaDarah, tesProteinUrine) {
                                        _updateLabData(
                                          hemoglobin,
                                          golonganDarah,
                                          gulaDarah,
                                          tesProteinUrine,
                                        );
                                      },
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Color(0xFFFCE4EC)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: Text(
                                    'Ubah Detail',
                                    style: TextStyle(
                                      color: Color(0xFFF06292),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Color(0xFFFCE4EC), // Warna pink muda
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              // Ikon Kalender
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Color(0xFFF06292), // Pink ikon
                                size: 32,
                              ),
                              SizedBox(width: 16),

                              // Informasi Teks
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Hari Pertama Haid Terakhir',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      data.hpht ?? '05 Oktober 2025',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Color(
                                          0xFF2D3142,
                                        ), // Warna teks gelap
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Tombol Ubah
                              TextButton(
                                onPressed: () {
                                  EditHPHTDialog.show(
                                    context,
                                    data,
                                    onSave: (hpht) {
                                      _updateHPHTData(hpht);
                                    },
                                  );
                                },
                                child: Text(
                                  'Ubah',
                                  style: TextStyle(
                                    color: Color(0xFFF06292),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            // Tombol Export PDF
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.picture_as_pdf_outlined,
                                  color: Color(0xFFF06292),
                                ),
                                label: Text(
                                  "Export PDF",
                                  style: TextStyle(
                                    color: Color(0xFF455A64),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  side: BorderSide(color: Colors.grey.shade300),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 12), // Jarak antar tombol
                            // Tombol Export CSV
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.table_chart_outlined,
                                  color: Color(0xFFF06292),
                                ),
                                label: Text(
                                  "Export CSV",
                                  style: TextStyle(
                                    color: Color(0xFF455A64),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  side: BorderSide(color: Colors.grey.shade300),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  String _formatValue(String? value) {
    if (value == null || value.isEmpty || value == '-') {
      return '-';
    }
    return value;
  }

  void _showSuccessNotification(String subtitle) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) {
        Future.delayed(Duration(seconds: 2), () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Container(
              width: 280,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon dengan background lingkaran
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFE0F2F1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Color(0xFF00796B),
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Judul
                  Text(
                    'Perubahan Tersimpan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),

                  // Subtitle
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _updateDetailData(
    String nameFaskes,
    String tenagaMedis,
    String tanggalKontrol,
  ) {
    final data = controller.detailData.value;
    if (data != null) {
      // Update data di controller
      data.nameFaskes = nameFaskes;
      data.tenagaMedis = tenagaMedis;
      data.tanggalKontrol = tanggalKontrol;

      // Trigger UI update dengan merefresh observable
      controller.detailData.refresh();

      // Tampilkan notifikasi custom
      _showSuccessNotification('Detail Pemeriksaan Berhasil Tersimpan');
    }
  }

  void _updatePhysicalExamData(
    String tekananDarah,
    String beratBadan,
    String tinggiBadan,
    String imt,
    String tinggiRahim,
    String lingkarLenganAtas,
  ) {
    final data = controller.detailData.value;
    if (data != null) {
      // Update data di controller (simpan kosong jika input kosong, bukan "-")
      data.tekananDarah = tekananDarah.isEmpty ? null : tekananDarah;
      data.beratBadan = beratBadan.isEmpty ? null : beratBadan;
      data.tinggiBadan = tinggiBadan.isEmpty ? null : tinggiBadan;
      data.imt = imt.isEmpty ? null : imt;
      data.tinggiRahim = tinggiRahim.isEmpty ? null : tinggiRahim;
      data.lingkarLenganAtas = lingkarLenganAtas.isEmpty ? null : lingkarLenganAtas;

      // Trigger UI update dengan merefresh observable
      controller.detailData.refresh();

      // Tampilkan notifikasi custom
      _showSuccessNotification('Data Pemeriksaan Fisik Berhasil Tersimpan');
    }
  }

  void _updateLabData(
    String hemoglobin,
    String golonganDarah,
    String gulaDarah,
    String tesProteinUrine,
  ) {
    final data = controller.detailData.value;
    if (data != null) {
      // Update data di controller
      data.hemoglobin = hemoglobin.isEmpty ? null : hemoglobin;
      data.golonganDarah = golonganDarah;
      data.gulaDarah = gulaDarah.isEmpty ? null : gulaDarah;
      data.tesProteinUrine = tesProteinUrine;

      // Trigger UI update dengan merefresh observable
      controller.detailData.refresh();

      // Tampilkan notifikasi custom
      _showSuccessNotification('Data Tes Lab Berhasil Tersimpan');
    }
  }

  void _updateHPHTData(String hpht) {
    final data = controller.detailData.value;
    if (data != null) {
      // Update data di controller
      data.hpht = hpht;

      // Trigger UI update dengan merefresh observable
      controller.detailData.refresh();

      // Tampilkan notifikasi custom
      _showSuccessNotification('Hari Pertama Haid Terakhir Berhasil Tersimpan');
    }
  }

  // Helper method untuk build info card
  Widget buildInfoCard(String title, String value, String unit) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0xFFFCE4EC),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 4),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method untuk mendapatkan warna background Protein Urine
  Color _getProteinUrineColor(String? value) {
    if (value == null || value.isEmpty) {
      return Color(0xFFE8F5E9); // Hijau muda
    }
    if (value.contains('Negatif')) {
      return Color(0xFFE8F5E9); // Hijau muda
    } else if (value.contains('Positif')) {
      return Color(0xFFFCE4EC); // Pink muda
    }
    return Color(0xFFE8F5E9);
  }

  // Helper method untuk mendapatkan warna teks Protein Urine
  Color _getProteinUrineTextColor(String? value) {
    if (value == null || value.isEmpty) {
      return Color(0xFF4CAF50); // Hijau
    }
    if (value.contains('Negatif')) {
      return Color(0xFF4CAF50); // Hijau
    } else if (value.contains('Positif')) {
      return Color(0xFFF06292); // Pink
    }
    return Color(0xFF4CAF50);
  }

}
