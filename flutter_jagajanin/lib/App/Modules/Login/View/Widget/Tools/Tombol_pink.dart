import 'package:flutter/material.dart';

class ButtonPink extends StatelessWidget {
  final String? Nama;
  final VoidCallback? onPressed;
  final Widget? navigationPage;

  const ButtonPink({
    super.key, 
    required this.Nama, 
    this.onPressed,
    this.navigationPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, 
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            // Jika ada callback, jalankan callback (untuk GetX)
            onPressed!();
          } else if (navigationPage != null) {
            // Jika ada widget, navigate ke widget tersebut (untuk Navigator.push)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => navigationPage!),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF48FB1), // Warna latar belakang
          foregroundColor: Colors.white, // Warna teks
        ),
        child: Text(Nama ?? 'No Name set'),
      ),
    );
  }
}
