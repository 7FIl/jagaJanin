class FoodEntry {
  final String id;
  final String name;
  final String category; // 'Makanan Pokok', 'Sayuran', 'Lauk Pauk'
  final double calories;
  final String unit;
  final double quantity;
  final DateTime date;
  final String? imagePath;

  FoodEntry({
    required this.id,
    required this.name,
    required this.category,
    required this.calories,
    required this.unit,
    required this.quantity,
    required this.date,
    this.imagePath,
  });

  double get totalCalories => calories * quantity;
}

class DailyFoodLog {
  final DateTime date;
  final List<FoodEntry> entries;

  DailyFoodLog({
    required this.date,
    required this.entries,
  });

  double get totalCalories => entries.fold(0, (sum, entry) => sum + entry.totalCalories);
  
  int get targetCalories => 2200;
}
