class PregnancyModel {
  int minggu;
  String hpl;
  String? status;
  double? progress;
  int? trimester;
  String? nameFaskes;
  String? tenagaMedis;
  String? tanggalKontrol;
  String? tekananDarah;
  String? beratBadan;
  String? tinggiBadan;
  String? imt;
  String? tinggiRahim;
  String? lingkarLenganAtas;
  String? hemoglobin;
  String? golonganDarah;
  String? gulaDarah;
  String? tesProteinUrine;
  String? hpht;

  PregnancyModel({
    required this.minggu,
    required this.hpl,
    required this.status,
    required this.progress,
    required this.trimester,
    this.nameFaskes = 'RSIA Bunda',
    this.tenagaMedis = 'Dr. Sarah Aulia',
    this.tanggalKontrol = '15 Maret 2026',
    this.tekananDarah,
    this.beratBadan,
    this.tinggiBadan,
    this.imt,
    this.tinggiRahim,
    this.lingkarLenganAtas,
    this.hemoglobin = '12.4',
    this.golonganDarah = 'O+',
    this.gulaDarah = '98',
    this.tesProteinUrine = 'Negatif(-)',
    this.hpht = '05 Oktober 2025',
  });
}