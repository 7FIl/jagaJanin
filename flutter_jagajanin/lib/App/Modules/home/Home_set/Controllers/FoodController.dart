import 'package:get/get.dart';
import 'package:flutter_jagajanin/App/Modules/home/Home_set/Models/food_model.dart';

class FoodController extends GetxController {
  static FoodController get instance => Get.find();

  late RxList<DailyFoodLog> weeklyLogs = <DailyFoodLog>[].obs;
  late Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    _initializeDummyData();
  }

  void _initializeDummyData() {
    List<DailyFoodLog> logs = [];
    for (int i = 0; i < 7; i++) {
      DateTime date = DateTime.now().subtract(Duration(days: 6 - i));
      List<FoodEntry> entries = [];
      
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
    
    weeklyLogs.assignAll(logs);
    selectedDate.value = DateTime.now();
  }

  DailyFoodLog? get currentDayLog {
    try {
      return weeklyLogs.firstWhere(
        (log) => log.date.day == selectedDate.value.day &&
            log.date.month == selectedDate.value.month &&
            log.date.year == selectedDate.value.year,
      );
    } catch (e) {
      return null;
    }
  }

  void addFoodEntry(FoodEntry entry) {
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
      int index = weeklyLogs.indexOf(logForEntryDate);
      List<FoodEntry> updatedEntries = [...logForEntryDate.entries, entry];
      weeklyLogs[index] = DailyFoodLog(
        date: logForEntryDate.date,
        entries: updatedEntries,
      );
    } else {
      weeklyLogs.add(DailyFoodLog(
        date: entry.date,
        entries: [entry],
      ));
    }
    selectedDate.value = entry.date;
    weeklyLogs.refresh();
  }

  void deleteFoodEntry(DateTime date, FoodEntry entry) {
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
      List<FoodEntry> updatedEntries = logForDate.entries.where((e) => e.id != entry.id).toList();
      weeklyLogs[index] = DailyFoodLog(
        date: logForDate.date,
        entries: updatedEntries,
      );
      weeklyLogs.refresh();
    }
  }

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }
}
