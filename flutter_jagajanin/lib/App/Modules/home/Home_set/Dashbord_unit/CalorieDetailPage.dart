import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Models/food_model.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Dashbord_unit/FoodLogPage.dart';

class CalorieDetailPage extends StatefulWidget {
  final List<DailyFoodLog> weeklyLogs;
  final Function(DateTime) onDateSelected;
  final Function(FoodEntry) onFoodAdded;
  final Function(DateTime, FoodEntry)? onFoodDeleted;

  const CalorieDetailPage({
    super.key,
    required this.weeklyLogs,
    required this.onDateSelected,
    required this.onFoodAdded,
    this.onFoodDeleted,
  });

  @override
  State<CalorieDetailPage> createState() => _CalorieDetailPageState();
}

class _CalorieDetailPageState extends State<CalorieDetailPage> {
  DateTime selectedDate = DateTime.now();
  late DateTime currentWeekStart;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    // Set currentWeekStart ke minggu dari selectedDate
    currentWeekStart = _getWeekStart(selectedDate);
  }

  // Mendapatkan hari Senin dari minggu yang mengandung date tersebut
  DateTime _getWeekStart(DateTime date) {
    // weekday: 1 = Senin, 7 = Minggu
    int daysToSubtract = date.weekday - 1;
    return date.subtract(Duration(days: daysToSubtract));
  }

  // Filter logs untuk minggu tertentu
  List<DailyFoodLog> _getWeeklyLogsForWeek(DateTime weekStart) {
    DateTime weekEnd = weekStart.add(const Duration(days: 6));
    return widget.weeklyLogs.where((log) {
      return log.date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
          log.date.isBefore(weekEnd.add(const Duration(days: 1)));
    }).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  // Get minggu sebelumnya
  void _previousWeek() {
    setState(() {
      currentWeekStart = currentWeekStart.subtract(const Duration(days: 7));
    });
  }

  // Get minggu berikutnya
  void _nextWeek() {
    setState(() {
      currentWeekStart = currentWeekStart.add(const Duration(days: 7));
    });
  }

  // Format label minggu
  String _getWeekLabel() {
    DateTime weekEnd = currentWeekStart.add(const Duration(days: 6));
    return '${currentWeekStart.day} - ${weekEnd.day} ${_getBulanName(weekEnd.month)} ${weekEnd.year}';
  }

  String _getBulanName(int month) {
    const List<String> bulan = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return bulan[month - 1];
  }

  DailyFoodLog? get currentDayLog {
    try {
      return widget.weeklyLogs.firstWhere(
        (log) => log.date.day == selectedDate.day &&
            log.date.month == selectedDate.month &&
            log.date.year == selectedDate.year,
      );
    } catch (e) {
      return null;
    }
  }

  void _navigateToFoodLog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodLogPage(
          currentDayLog: currentDayLog,
          onFoodAdded: (entry) {
            widget.onFoodAdded(entry);
            setState(() {}); // Trigger rebuild untuk refresh data
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
          weeklyLogs: widget.weeklyLogs,
          onDateSelected: (date) {
            setState(() => selectedDate = date);
          },
          onFoodAdded: widget.onFoodAdded,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dapatkan logs untuk minggu sekarang
    List<DailyFoodLog> weeklyLogsForCurrentWeek = _getWeeklyLogsForWeek(currentWeekStart);
    
    double getTotalCalories() {
      return weeklyLogsForCurrentWeek.fold(0, (sum, log) => sum + log.totalCalories);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Detail Kalori Mingguan',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Riwayat Konsumsi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Minggu: ${_getWeekLabel()}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Total Kalori Minggu Ini',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${getTotalCalories().toStringAsFixed(0)} kcal',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE91E63),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Target/hari',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '2.200 kcal',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Navigation Minggu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFF48FB1)),
                    onPressed: _previousWeek,
                  ),
                  Text(
                    'Minggu: ${_getWeekLabel()}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFFF48FB1)),
                    onPressed: _nextWeek,
                  ),
                ],
              ),
            ),

            // Grafik Mingguan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Grafik Kalori Mingguan',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 220,
                      child: _buildAreaChart(weeklyLogsForCurrentWeek),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF48FB1),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    side: const BorderSide(color: Color(0xFFF48FB1), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _navigateToFoodLog,
                    child: const Text(
                    '+ Tambah Log Makanan',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            // Riwayat Harian
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                'Riwayat Harian',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            
            ...weeklyLogsForCurrentWeek.map((log) {
              bool isSelected = log.date.day == selectedDate.day &&
                  log.date.month == selectedDate.month &&
                  log.date.year == selectedDate.year;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedDate = log.date);
                    widget.onDateSelected(log.date);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFF5E6F0) : Colors.white,
                      border: Border.all(
                        color: isSelected ? const Color(0xFFF48FB1) : Colors.grey[300]!,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${log.date.day} Maret ${log.date.year}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${log.entries.length} makanan',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${log.totalCalories.toStringAsFixed(0)} kcal',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE91E63),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Tampilkan nama-nama makanan
                        Text(
                          log.entries.map((e) => e.name).join(', '),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        // Action buttons: Edit dan Delete
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Edit button
                            GestureDetector(
                              onTap: () {
                                // TODO: Implement edit functionality
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Color(0xFFF48FB1),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Delete button
                            GestureDetector(
                              onTap: () => _showDeleteConfirmation(log),
                              child: const Icon(
                                Icons.delete_outline,
                                color: Color(0xFFEF5350),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Show delete confirmation dialog
  void _showDeleteConfirmation(DailyFoodLog log) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Trash icon dengan background circle
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCE4EC),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.delete_outline,
                      color: Color(0xFFEF5350),
                      size: 45,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Title
                const Text(
                  'Hapus Log Makan?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                // Subtitle
                const Text(
                  'Log Makan akan Terhapus dan tidak dapat dipulihkan',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                // Hapus Log Makan button (red)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      // Call delete callback
                      if (widget.onFoodDeleted != null) {
                        // Delete all entries for this day
                        for (var entry in log.entries) {
                          widget.onFoodDeleted!(log.date, entry);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF5350),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Hapus Log Makan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Batal button (white/outline)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Batal',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAreaChart(List<DailyFoodLog> currentWeekLogs) {
    // Create spots untuk semua hari dalam minggu (Senin-Minggu)
    List<FlSpot> spots = [];
    List<String> dayLabels = [];
    
    for (int i = 0; i < 7; i++) {
      DateTime dayDate = currentWeekStart.add(Duration(days: i));
      dayLabels.add('${dayDate.day}');
      
      // Cari log untuk hari tersebut
      try {
        DailyFoodLog dailyLog = currentWeekLogs.firstWhere(
          (log) => log.date.day == dayDate.day &&
              log.date.month == dayDate.month &&
              log.date.year == dayDate.year,
        );
        spots.add(FlSpot(i.toDouble(), dailyLog.totalCalories));
      } catch (e) {
        // Jika tidak ada log untuk hari itu, tambah 0
        spots.add(FlSpot(i.toDouble(), 0));
      }
    }

    // Hitung maxY berdasarkan kalori maksimal yang ada
    double maxCalories = spots.isEmpty 
        ? 2500 
        : (spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) * 1.2).clamp(2200, double.infinity);

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
                if (value.toInt() >= 0 && value.toInt() < dayLabels.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text(
                          days[value.toInt()],
                          style: const TextStyle(
                            color: Color(0xFFB8869B),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          dayLabels[value.toInt()],
                          style: const TextStyle(
                            color: Color(0xFFB8869B),
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 50,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: maxCalories,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.35,
            color: const Color(0xFFE8889F),
            barWidth: 2.8,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFFF8D9E8),
              spotsLine: const BarAreaSpotsLine(show: false),
            ),
          ),
        ],
        lineTouchData: LineTouchData(enabled: false),
      ),
    );
  }
}
