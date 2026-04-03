import 'package:flutter/material.dart';

class KotakInfo extends StatelessWidget {
  final String judul;
  final String? isi;
  final Color? warnaTeks; 

  const KotakInfo({
    super.key, 
    required this.judul,
    required this.isi,
    this.warnaTeks,
    });

  @override
  Widget build(BuildContext context) {
    return Expanded( // Expanded agar kotaknya membagi lebar layar sama rata
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.pink.shade100, width: 1.5), // Garis pinggir pink
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(judul, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              isi ?? "Belum diisi", 
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 14, 
                color: warnaTeks ?? Colors.black87 // Jika warna diisi, pakai warnanya. Jika tidak, pakai hitam
              ),
            ),
          ],
        ),
      ),
    );
  }
}