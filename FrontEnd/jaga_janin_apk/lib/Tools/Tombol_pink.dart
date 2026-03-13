import 'package:flutter/material.dart';

class ButtonPink extends StatelessWidget {
  final String? Nama;
  final Widget? onPressed;

  const ButtonPink({super.key, required this.Nama, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, 
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => onPressed ?? Container()),
          );
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
