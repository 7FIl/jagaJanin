import 'package:flutter/material.dart';

class JadwalKonsultasiCard extends StatelessWidget {
  final String tanggal;
  final String dokter;

  const JadwalKonsultasiCard({
    super.key,
    required this.tanggal,
    required this.dokter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFFFD1DC), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFFCE4EC), // Pink sangat muda (latar ikon)
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.calendar_month_rounded,
                color: Color(0xFFE594AB), // Warna ikon pink
                size: 30,
              ),
            ),
            const SizedBox(width: 16), // Jarak antara ikon dan teks
            // Bagian Teks
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${tanggal}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3142), // Warna teks gelap
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${dokter}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7E8CA0), // Warna teks abu-abu kebiruan
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
