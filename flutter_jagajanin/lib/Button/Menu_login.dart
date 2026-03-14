import 'package:flutter/material.dart';

class TombolNavigasi extends StatelessWidget {
  final String teks;
  final Widget halamanTujuan; 
  final Color warna;
  final Color textColor;
  // <-- 1. Ini parameter penampung halamannya!

  const TombolNavigasi({
    super.key,
    required this.textColor,
    required this.warna,
    required this.teks,
    required this.halamanTujuan, // <-- 2. Wajib diisi saat tombol dipanggil
  });

  @override
  Widget build(BuildContext context) {
    
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: warna, // Warna latar belakang putih
        padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Membuat tombol menjadi bulat
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => halamanTujuan),
        );
      },
      child: Text(
        teks,
        style: TextStyle(color: textColor, fontSize: 15),
      ),
    );
  }
}