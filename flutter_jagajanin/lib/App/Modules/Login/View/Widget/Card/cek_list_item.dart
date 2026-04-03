import 'package:flutter/material.dart';

Widget buildChecklistItem(String title, bool isSelected, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
        // Bungkus Container dengan GestureDetector agar bisa diklik
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 24, // Sedikit diperbesar agar ikon centang muat
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // Logika warna: Pink jika true, Transparan jika false
              color: isSelected ? const Color(0xFFE594AB) : Colors.transparent,
              border: Border.all(
                color: isSelected ? const Color(0xFFE594AB) : Colors.grey,
                width: 2,
              ),
            ),
            // Logika ikon: Tampilkan centang jika true
            child: isSelected
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
        ),
      ],
    ),
  );
}