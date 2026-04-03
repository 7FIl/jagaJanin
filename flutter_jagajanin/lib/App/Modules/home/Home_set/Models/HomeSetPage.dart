import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Dashbord_unit/CalorieDetailPage.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Models/food_model.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Dashbord_unit/FoodLogPage.dart';

class HomeSetPage extends StatefulWidget {
  const HomeSetPage({super.key});

  @override
  State<HomeSetPage> createState() => _HomeSetPageState();
}

class _HomeSetPageState extends State<HomeSetPage> {
  List<DailyFoodLog> weeklyLogs = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initializeDummyData();
  }

  void _initializeDummyData() {
    // Initialize dummy data untuk minggu ini
    List<DailyFoodLog> logs = [];
    for (int i = 0; i < 7; i++) {
      DateTime date = DateTime.now().subtract(Duration(days: 6 - i));
      List<FoodEntry> entries = [];
      
      // Tambahkan beberapa dummy entries
      if (i > 0) {
        entries = [
          FoodEntry(
            id: '$i-1',
            name: 'Nasi Putih',
            category: 'Makanan Pokok',
            calories: 100,
            unit: 'centong',
            quantity: 1,
            date: date,
          ),
          FoodEntry(
            id: '$i-2',
            name: 'Sayuran',
            category: 'Sayuran',
            calories: 30,
            unit: 'potong',
            quantity: 2,
            date: date,
          ),
          FoodEntry(
            id: '$i-3',
            name: 'Ayam Goreng',
            category: 'Lauk Pauk',
            calories: 165,
            unit: 'gram',
            quantity: 1,
            date: date,
          ),
        ];
      }
      
      logs.add(DailyFoodLog(date: date, entries: entries));
    }
    
    setState(() {
      weeklyLogs = logs;
      selectedDate = DateTime.now();
    });
  }

  DailyFoodLog? get currentDayLog {
    try {
      return weeklyLogs.firstWhere(
        (log) => log.date.day == selectedDate.day &&
            log.date.month == selectedDate.month &&
            log.date.year == selectedDate.year,
      );
    } catch (e) {
      return null;
    }
  }

  void _addFoodEntry(FoodEntry entry) {
    setState(() {
      // Cari log berdasarkan tanggal dari entry (bukan selectedDate HomeSetPage)
      DailyFoodLog? logForEntryDate;
      try {
        logForEntryDate = weeklyLogs.firstWhere(
          (log) => log.date.day == entry.date.day &&
              log.date.month == entry.date.month &&
              log.date.year == entry.date.year,
        );
      } catch (e) {
        logForEntryDate = null;
      }

      if (logForEntryDate != null) {
        // Jika log untuk tanggal entry sudah ada → tambahkan entry ke log tersebut
        int index = weeklyLogs.indexOf(logForEntryDate);
        List<FoodEntry> updatedEntries = [...logForEntryDate.entries, entry];
        weeklyLogs[index] = DailyFoodLog(
          date: logForEntryDate.date,
          entries: updatedEntries,
        );
      } else {
        // Jika belum ada log untuk tanggal entry → buat log baru
        weeklyLogs.add(DailyFoodLog(
          date: entry.date,
          entries: [entry],
        ));
      }

      // Update selectedDate ke tanggal entry yang baru ditambahkan
      selectedDate = entry.date;
    });
  }

  void _deleteFoodEntry(DateTime date, FoodEntry entry) {
    setState(() {
      // Cari log untuk tanggal yang diberikan
      DailyFoodLog? logForDate;
      try {
        logForDate = weeklyLogs.firstWhere(
          (log) => log.date.day == date.day &&
              log.date.month == date.month &&
              log.date.year == date.year,
        );
      } catch (e) {
        logForDate = null;
      }

      if (logForDate != null) {
        int index = weeklyLogs.indexOf(logForDate);
        
        // Hapus entry dari list
        List<FoodEntry> updatedEntries = logForDate.entries.where((e) => e.id != entry.id).toList();
        
        // Selalu update DailyFoodLog, bahkan jika entries kosong (akan menunjukkan 0 kcal)
        weeklyLogs[index] = DailyFoodLog(
          date: logForDate.date,
          entries: updatedEntries,
        );
      }
    });
  }

  void _navigateToFoodLog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodLogPage(
          currentDayLog:  currentDayLog,
          onFoodAdded: _addFoodEntry,
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
          weeklyLogs: weeklyLogs,
          onDateSelected: (date) {
            setState(() => selectedDate = date);
          },
          onFoodAdded: _addFoodEntry,
          onFoodDeleted: _deleteFoodEntry,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DailyFoodLog? todayLog = currentDayLog;
    double totalCalories = todayLog?.totalCalories ?? 0;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Panduan Makan',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Konsumsi Hari Ini Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFC0DB), Color(0xFFF48FB1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Konsumsi Hari Ini',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${totalCalories.toStringAsFixed(0)} kcal',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'dari 2.200 kcal',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          child: Center(
                            child: Text(
                              '${((totalCalories / 2200) * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // Menu Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Akses Cepat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildMenuCard(
                        title: 'Log Makanan Harian',
                        subtitle: '${todayLog?.entries.length ?? 0} makanan',
                        icon: Icons.lunch_dining,
                        color: const Color(0xFFFFC0DB),
                        onTap: _navigateToFoodLog,
                      ),
                      _buildMenuCard(
                        title: 'Detail Kalori Mingguan',
                        subtitle: 'Grafik & Riwayat',
                        icon: Icons.show_chart,
                        color: const Color(0xFFE1BEE7),
                        onTap: _navigateToCalorieDetail,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Food Categories Preview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kategori Makanan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildFoodCategoryCard(
                    'Makanan Pokok',
                    Icons.rice_bowl,
                    Colors.blue,
                  ),
                  const SizedBox(height: 12),
                  _buildFoodCategoryCard(
                    'Sayuran',
                    Icons.eco,
                    Colors.green,
                  ),
                  const SizedBox(height: 12),
                  _buildFoodCategoryCard(
                    'Lauk Pauk',
                    Icons.egg,
                    Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodCategoryCard(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(icon, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(Icons.arrow_forward, color: color),
        ],
      ),
    );
  }

}
