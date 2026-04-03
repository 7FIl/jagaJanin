import 'package:flutter/material.dart';

class Halaman2 extends StatefulWidget {
  const Halaman2({super.key});

  @override
  State<Halaman2> createState() => _Halaman2State();
}

class _Halaman2State extends State<Halaman2> {
  int? selectedTrimester;

  final List<TrimesterOption> trimesters = [
    TrimesterOption(
      title: "Aktivitas Rendah",
      subtitle:
          "Sebagian waktu dihabiskan dengan duduk, beristirahat, atau melakukan sedikit gerakan sepanjang hari.",
      stage: 1,
      icon: const Icon(Icons.weekend, color: Colors.pinkAccent, size: 30),
    ),
    TrimesterOption(
      title: "Aktivitas Sedang",
      subtitle:
          "Pekerjaan rumah tangga ringan, berjakan kaki, atau berdiri sebagian waktu dalam sehari.",
      stage: 2,
      icon: const Icon(
        Icons.directions_walk,
        color: Colors.pinkAccent,
        size: 30,
      ),
    ),
    TrimesterOption(
      title: "Aktivitas Tinggi",
      subtitle:
          "Aktivitas fisik, olahraga, atau pekerjaan yang membutuhkan tenaga fisik secara sering.",
      stage: 3,
      icon: const Icon(
        Icons.fitness_center,
        color: Colors.pinkAccent,
        size: 30,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Center(
                child: Text(
                  'Seberapa aktif Bunda dalam \nberkegiatan sehari-hari?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // Trimester Options
              Column(
                children: List.generate(trimesters.length, (index) {
                  final trimester = trimesters[index];
                  final isSelected = selectedTrimester == trimester.stage;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTrimester = trimester.stage;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(color: Colors.pinkAccent, width: 2)
                            : Border.all(color: Colors.transparent, width: 2),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            trimester.icon?.icon ?? Icons.help_outline,
                            color: trimester.icon?.color ?? Colors.grey,
                            size: trimester.icon?.size ?? 24,
                          ),
                          const SizedBox(width: 16),
                          // Text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trimester.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  trimester.subtitle,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 8), // Heart Icon
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrimesterOption {
  final String title;
  final String subtitle;
  final int stage;
  final Icon? icon;

  TrimesterOption({
    required this.title,
    required this.subtitle,
    required this.stage,
    this.icon,
  });
}
