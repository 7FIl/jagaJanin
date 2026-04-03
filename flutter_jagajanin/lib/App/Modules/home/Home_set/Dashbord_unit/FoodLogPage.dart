import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Models/food_model.dart';

class FoodLogPage extends StatefulWidget {
  final DailyFoodLog? currentDayLog;
  final Function(FoodEntry) onFoodAdded;
  final VoidCallback onNavigateToDetail;

  const FoodLogPage({
    super.key,
    this.currentDayLog,
    required this.onFoodAdded,
    required this.onNavigateToDetail,
  });

  @override
  State<FoodLogPage> createState() => _FoodLogPageState();
}

class _FoodLogPageState extends State<FoodLogPage> {
  DateTime selectedDate = DateTime.now();
  final List<String> _namaHari = [
    '',
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
    'Min',
  ];
  int _counter = 1;
  int _conterSayur = 1;
  int _counterLauk = 1;

  late double totalEstimatedCalories;
  String? selectedValueMakanan;
  String? selectedValueSayur;
  String? selectedValueLauk;
  int selectedFoodCategory = 0; // 0: Makanan Pokok, 1: Sayuran, 2: Lauk Pauk

  @override
  void initState() {
    super.initState();
    totalEstimatedCalories = widget.currentDayLog?.totalCalories ?? 0;
  }

  // Menyimpan perubahan dan menambahkan makanan ke log
  void _simpanPerubahan() {
    List<FoodEntry> entriesToAdd = [];

    // Tambahkan Makanan Pokok jika dipilih
    if (selectedValueMakanan != null) {
      double caloriesMakanan = _getCaloriesMakanan(selectedValueMakanan!);
      entriesToAdd.add(
        FoodEntry(
          id: '${DateTime.now().millisecondsSinceEpoch}_makanan_$selectedValueMakanan',
          name: selectedValueMakanan!,
          category: 'Makanan Pokok',
          calories: caloriesMakanan,
          unit: 'centong',
          quantity: _counter.toDouble(),
          date: selectedDate,
        ),
      );
    }

    // Tambahkan Sayuran jika dipilih
    if (selectedValueSayur != null) {
      double caloriesSayur = _getCaloriesSayur(selectedValueSayur!);
      entriesToAdd.add(
        FoodEntry(
          id: '${DateTime.now().millisecondsSinceEpoch}_sayur_$selectedValueSayur',
          name: selectedValueSayur!,
          category: 'Sayuran',
          calories: caloriesSayur,
          unit: 'centong',
          quantity: _conterSayur.toDouble(),
          date: selectedDate,
        ),
      );
    }

    // Tambahkan Lauk Pauk jika dipilih
    if (selectedValueLauk != null) {
      double caloriesLauk = _getCaloriesLauk(selectedValueLauk!);
      entriesToAdd.add(
        FoodEntry(
          id: '${DateTime.now().millisecondsSinceEpoch}_lauk_$selectedValueLauk',
          name: selectedValueLauk!,
          category: 'Lauk Pauk',
          calories: caloriesLauk,
          unit: 'centong',
          quantity: _counterLauk.toDouble(),
          date: selectedDate,
        ),
      );
    }

    // Panggil callback untuk setiap entry
    for (var entry in entriesToAdd) {
      widget.onFoodAdded(entry);
    }

    // Reset form
    _resetForm();

    // Tampilkan animasi sukses
    _showSuccessAnimation();
  }

  // Tampilkan animasi success
  void _showSuccessAnimation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AnimatedSuccessDialog(
          onAnimationComplete: () {
            Navigator.pop(context); // Close dialog
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) {
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              }
            });
          },
        );
      },
    );
  }

  // Reset form ke kondisi awal
  void _resetForm() {
    setState(() {
      selectedValueMakanan = null;
      selectedValueSayur = null;
      selectedValueLauk = null;
      _counter = 1;
      _conterSayur = 1;
      _counterLauk = 1;
      totalEstimatedCalories = 0;
    });
  }

  // Mendapatkan kalori untuk makanan pokok
  double _getCaloriesMakanan(String makanan) {
    final Map<String, double> caloriesMap = {
      'Nasi Putih': 130,
      'Nasi Merah': 111,
      'Ubi': 103,
      'Kentang': 77,
    };
    return caloriesMap[makanan] ?? 100; // Per 100g (1 centong)
  }

  // Mendapatkan kalori untuk sayuran
  double _getCaloriesSayur(String sayuran) {
    final Map<String, double> caloriesMap = {
      'Kangkung': 29,
      'Bayam': 23,
      'Brokoli': 34,
      'Wortel': 41,
    };
    return caloriesMap[sayuran] ?? 30; // Per 100g (1 centong)
  }

  // Mendapatkan kalori untuk lauk pauk
  double _getCaloriesLauk(String lauk) {
    final Map<String, double> caloriesMap = {
      'Ayam': 165,
      'Ikan': 82,
      'Telur': 155,
      'Daging': 250,
    };
    return caloriesMap[lauk] ?? 150; // Per 100g (1 centong)
  }

  List<DateTime> get _limaHariTerakhir {
    return List.generate(4, (index) {
      return selectedDate.subtract(Duration(days: 3 - index));
    });
  }

  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020), // Batas tahun bawah
      lastDate: DateTime(2030), // Batas tahun atas
      builder: (context, child) {
        // Tema kalender agar warnanya pink (sesuai gambar ke-2)
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE8889F), // Warna header & tombol (Pink)
              onPrimary: Colors.white, // Warna teks di header
              onSurface: Colors.black, // Warna teks kalender
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Reset form ketika ganti tanggal
        _resetForm();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Log Makanan Harian',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.black),
            onPressed: widget.onNavigateToDetail,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink.shade100, width: 1.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF48FB1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(
                            "Catat Makanan yang Bunda Konsumsi Hari Ini",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),

                    Text("Pilih tanggal", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Looping untuk membuat kotak tanggal
                          ..._limaHariTerakhir
                              .map((date) => _buildKotakTanggal(date))
                              .toList(),

                          // Tombol ikon kalender di ujung kanan
                          GestureDetector(
                            onTap: () => _pilihTanggal(context),
                            child: Container(
                              margin: const EdgeInsets.only(left: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.calendar_month,
                                color: Colors.black54,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFF48FB1)),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 20, height: 10),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: const Color.fromARGB(
                            255,
                            101,
                            156,
                            251,
                          ),
                          child: Icon(
                            Icons.rice_bowl,
                            color: Colors.blueAccent,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Makanan Pokok",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.pink.shade100,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          hint: const Text("Pilih sumber karbohidrat"),
                          value: selectedValueMakanan,
                          icon: const Icon(
                            Icons.expand_more,
                            color: Colors.pink,
                          ),
                          items:
                              <String>[
                                'Nasi Putih',
                                'Nasi Merah',
                                'Ubi',
                                'Kentang',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedValueMakanan = val;
                            });
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Bagian Penambah Jumlah
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFFDEEF4,
                              ), // Background pink muda
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                _buildCounterButton(
                                  Icons.remove,
                                  Colors.white,
                                  Colors.grey.shade300,
                                  () {
                                    setState(() {
                                      if (_counter > 1) {
                                        _counter--;
                                      }
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "$_counter",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                _buildCounterButton(
                                  Icons.add,
                                  Colors.white,
                                  Colors.pink.shade200,
                                  () {
                                    setState(() {
                                      _counter++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          // Bagian Teks Keterangan (Rata Kanan)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "centong",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "1 centong ≈ 100 gram",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade400,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFF48FB1)),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 20, height: 10),
                        CircleAvatar(
                          radius: 17,
                          backgroundColor: Color(0x3343A047),
                          child: Icon(Icons.eco, color: Colors.green, size: 20),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Sayuran",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.pink.shade100,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          hint: const Text("Pilih jenis sayuran"),
                          value: selectedValueSayur,
                          icon: const Icon(
                            Icons.expand_more,
                            color: Colors.pink,
                          ),
                          items:
                              <String>[
                                'Kangkung',
                                'Bayam',
                                'Brokoli',
                                'Wortel',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedValueSayur = val;
                            });
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Bagian Penambah Jumlah
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFFDEEF4,
                              ), // Background pink muda
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                _buildCounterButton(
                                  Icons.remove,
                                  Colors.white,
                                  Colors.grey.shade300,
                                  () {
                                    setState(() {
                                      if (_conterSayur > 1) {
                                        _conterSayur--;
                                      }
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "$_conterSayur",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                _buildCounterButton(
                                  Icons.add,
                                  Colors.white,
                                  Colors.pink.shade200,
                                  () {
                                    setState(() {
                                      _conterSayur++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          // Bagian Teks Keterangan (Rata Kanan)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "centong",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "1 centong ≈ 100 gram",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade400,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFF48FB1)),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 20, height: 10),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: const Color(0xFFF48FB1),
                          child: FaIcon(
                            FontAwesomeIcons.drumstickBite,
                            color: Colors.red,
                            size: 15,
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          "Lauk Pauk",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.pink.shade100,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          hint: const Text("Pilih sumber protein harian"),
                          value: selectedValueLauk,
                          icon: const Icon(
                            Icons.expand_more,
                            color: Colors.pink,
                          ),
                          items: <String>['Ayam', 'Ikan', 'Telur', 'Daging']
                              .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              })
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedValueLauk = val;
                            });
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Bagian Penambah Jumlah
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFFDEEF4,
                              ), // Background pink muda
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                _buildCounterButton(
                                  Icons.remove,
                                  Colors.white,
                                  Colors.grey.shade300,
                                  () {
                                    setState(() {
                                      if (_counterLauk > 1) {
                                        _counterLauk--;
                                      }
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "$_counterLauk",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                _buildCounterButton(
                                  Icons.add,
                                  Colors.white,
                                  Colors.pink.shade200,
                                  () {
                                    setState(() {
                                      _counterLauk++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          // Bagian Teks Keterangan (Rata Kanan)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "centong",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "1 centong ≈ 100 gram",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade400,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: Color(0xFFF48FB1), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tambah lauk lain - fitur segera hadir'),
                      ),
                    );
                  },
                  child: const Text(
                    '+ Tambah Lauk Lain',
                    style: TextStyle(
                      color: Color(0xFFF48FB1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Estimasi Kalori
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5E6F0),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Estimasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${(_conterSayur + _counterLauk + _counter) * 100} kcal',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        widthFactor: (totalEstimatedCalories / 2200).clamp(
                          0,
                          1,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF48FB1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildNutrientLabel(
                          'Makanan Pokok',
                          _counter * 100,
                          Colors.blue,
                        ),
                        _buildNutrientLabel(
                          'Lauk Pauk',
                          _counterLauk * 100,
                          Colors.orange,
                        ),
                        _buildNutrientLabel(
                          'Sayuran',
                          _conterSayur * 100,
                          Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            // Simpan Perubahan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF48FB1),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _simpanPerubahan,
                  child: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterButton(
    IconData icon,
    Color iconColor,
    Color bgColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap, // Menjalankan fungsi yang dikirim
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }

  Widget _buildNutrientLabel(String label, int grams, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
        const SizedBox(width: 4),
        Text(
          '${grams}g',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Widget pembantu untuk menggambar kotak tanggal (Sen 11, Sel 12, dll)
  Widget _buildKotakTanggal(DateTime date) {
    // Cek apakah kotak ini adalah tanggal yang sedang dipilih
    bool isSelected =
        date.day == selectedDate.day &&
        date.month == selectedDate.month &&
        date.year == selectedDate.year;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDate = date;
          _resetForm();
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF48FB1) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFFF48FB1) : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              _namaHari[date.weekday], // Menampilkan 'Sen', 'Sel'
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.black54,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${date.day}", // Menampilkan angka '11', '12'
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Animated Success Dialog Widget
class AnimatedSuccessDialog extends StatefulWidget {
  final VoidCallback onAnimationComplete;

  const AnimatedSuccessDialog({
    super.key,
    required this.onAnimationComplete,
  });

  @override
  State<AnimatedSuccessDialog> createState() => _AnimatedSuccessDialogState();
}

class _AnimatedSuccessDialogState extends State<AnimatedSuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();

    // Setelah animasi selesai, tunggu 2 detik kemudian callback
    Future.delayed(const Duration(milliseconds: 600), () {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          widget.onAnimationComplete();
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Checkmark Icon dengan background circle
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2F1),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Color(0xFF00796B),
                      size: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Title
                const Text(
                  'Perubahan Tersimpan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                // Subtitle
                const Text(
                  'Log Makan Harian Berhasil Tersimpan',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
    }