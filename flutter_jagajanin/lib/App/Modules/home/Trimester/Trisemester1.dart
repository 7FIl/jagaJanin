import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Dashbord_unit/Food_Log.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Dashbord_unit/CalorieDetailPage.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Dashbord_unit/FoodLogPage.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Models/food_model.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Controllers/FoodController.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Controllers/FoodController.dart';

class Trisemester1 extends StatefulWidget {
  const Trisemester1({super.key});

  @override
  State<Trisemester1> createState() => _Trisemester1State();
}

class _Trisemester1State extends State<Trisemester1> {
  FoodController get foodController {
    if (!Get.isRegistered<FoodController>()) {
      Get.put(FoodController());
    }
    return Get.find<FoodController>();
  }

  @override
  void initState() {
    super.initState();
  }


  void _navigateToFoodLog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodLogPage(
          currentDayLog: foodController.currentDayLog,
          onFoodAdded: (food) {
            foodController.addFoodEntry(food);
          },
          onNavigateToDetail: _navigateToCalorieDetail,
        ),
      ),
    );
  }

  void _navigateToCalorieDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalorieDetailPage(
          weeklyLogs: foodController.weeklyLogs.value,
          onDateSelected: (date) {
            foodController.setSelectedDate(date);
          },
          onFoodAdded: (food) {
            foodController.addFoodEntry(food);
          },
          onFoodDeleted: (date, food) {
            foodController.deleteFoodEntry(date, food);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFF48FB1)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 18,
                          color: Color(0xFFF48FB1),
                        ),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {}, // Trigger daftar minggu
                          child: const Center(
                            child: Text(
                              "Minggu ke-2",
                              style: TextStyle(
                                color: Color(0xFFF48FB1),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Color(0xFFF48FB1),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF48FB1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE497AA), // Warna pink background
                    borderRadius: BorderRadius.circular(20),
                    gradient: RadialGradient(
                      center: Alignment(
                        0.6,
                        -0.3,
                      ), // Sesuaikan pusat gradien (kanan agak atas)
                      radius: 1.5, // Atur seberapa luas gradien menyebar
                      colors: [
                        const Color(0xFFE497AA), // Warna pink pusat
                        const Color.fromARGB(
                          255,
                          233,
                          231,
                          231,
                        ), // Warna putih di pinggir
                      ],
                      stops: [0.0, 1.0], // Opsional: atur titik transisi warna
                    ),
                  ),

                  child: Column(
                    children: [
                      // Bagian atas (teks dan gambar)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Teks di kiri
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hai, Bunda Angel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'Si kecil sudah seukuran jeruk nipis lho! Terus jaga kesehatan ya.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          Image.asset(
                            'assets/img/buah.png', // Ganti path sesuai asetmu
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ),
                      const SizedBox(height: 25), // Jarak ke button
                      Stack(
                        clipBehavior: Clip.none, // Biarkan ikon menonjol keluar
                        alignment: Alignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                              elevation: 0, // Hilangkan shadow default button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Cek Perkembangan',
                              style: TextStyle(
                                color: Color(0xFFE497AA), // Teks warna pink
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFFDE1E7)),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.scale,
                          color: Color(0xFFF48FB1),
                        ), // Ganti dengan aset ikonmu
                        SizedBox(width: 10),
                        Text(
                          "Asupan Kalori Harian",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        // Lingkaran Progress
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: CircularPercentIndicator(
                            radius: 50,
                            lineWidth: 20,
                            percent: 0.7,
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Color(0xFFF48FB1),
                            backgroundColor: const Color.fromARGB(255, 240, 239, 239),
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "80%",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        // Teks Keterangan
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "1.300",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    " /2.000 kkal",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Sisa 700 kkal lagi untuk mencapai target nutrisi.",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFFDE1E7), width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    // Header
                    Row(
                      children: [
                        Icon(Icons.restaurant, color: Color(0xFFF48FB1)),
                        SizedBox(width: 10),
                        Text(
                          "Panduan Makan Harian",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    // Harga
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Rp 15.000", style: TextStyle(fontSize: 30)),
                        Text(
                          " /per porsi",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    // Baris Menu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFoodItem(
                          Icons.rice_bowl,
                          "Nasi",
                          "3 Centong",
                          "300 gram",
                          Color(0xFFDDEBFF),
                        ),
                        _buildFoodItem(
                          Icons.kebab_dining,
                          "Ayam",
                          "3 Centong",
                          "300 gram",
                          Color(0xFFFEE7E3),
                        ),
                        _buildFoodItem(
                          Icons.eco,
                          "Sayur",
                          "3 Centong",
                          "300 gram",
                          Color(0xFFE3F4E6),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    // Tombol
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF48FB1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          _navigateToFoodLog();
                        },
                        child: const Text(
                          "Lihat Detail",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFFDE1E7), width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Kalori Mingguan",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "+8,2%",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Lihat grafik perkembangan konsumsi kalori mingguanmu",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    // Area Grafik
                    SizedBox(
                      height: 150,
                      child: LineChart(
                        LineChartData(
                          minY: 1500,
                          maxY: 2500,
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  // Peta nilai X ke nama hari
                                  switch (value.toInt()) {
                                    case 0:
                                      return const Text(
                                        "Senin",
                                        style: TextStyle(fontSize: 11),
                                      );
                                    case 1:
                                      return const Text(
                                        "Selasa",
                                        style: TextStyle(fontSize: 11),
                                      );
                                    case 2:
                                      return const Text(
                                        "Rabu",
                                        style: TextStyle(fontSize: 11),
                                      );
                                    case 3:
                                      return const Text(
                                        "Kamis",
                                        style: TextStyle(fontSize: 11),
                                      );
                                    case 4:
                                      return const Text(
                                        "Jumat",
                                        style: TextStyle(fontSize: 11),
                                      );
                                    case 5:
                                      return const Text(
                                        "Sabtu",
                                        style: TextStyle(fontSize: 11),
                                      );
                                    case 6:
                                      return const Text(
                                        "Minggu",
                                        style: TextStyle(fontSize: 11),
                                      );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          clipData: FlClipData.all(),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                FlSpot(0, 1800),
                                FlSpot(1, 2000),
                                FlSpot(2, 1900),
                                FlSpot(3, 2100),
                                FlSpot(4, 2200),
                                FlSpot(5, 2050),
                                FlSpot(6, 1950),
                              ],
                              isCurved: true,
                              color: const Color(0xFFF48FB1),
                              barWidth: 4,
                              belowBarData: BarAreaData(
                                show: true,
                                color: const Color(0xFFF48FB1).withOpacity(0.2),
                              ),
                              dotData: FlDotData(show: false),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF48FB1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () {
                          _navigateToCalorieDetail();
                        },
                        child: const Text(
                          "Lihat Detail",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}

Widget _buildFoodItem(
  IconData icon,
  String title,
  String qty,
  String weight,
  Color bgColor,
) {
  return Column(
    children: [
      CircleAvatar(
        radius: 25,
        backgroundColor: bgColor,
        child: Icon(icon, color: Colors.black54),
      ),
      const SizedBox(height: 10),
      Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Text(qty, style: TextStyle(color: Colors.grey, fontSize: 12)),
      Text(weight, style: TextStyle(color: Colors.grey, fontSize: 12)),
    ],
  );
}
