import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String foodName;
  final String Porsi;
  final String imagePath;
  final String Ukuran;
  final String Harga;

  const FoodCard({super.key
    , required this.foodName
    , required this.Porsi
    , required this.imagePath
    , required this.Ukuran
    , required this.Harga
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFF48FB1), width: 2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      foodName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Porsi,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      Ukuran,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  Harga,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 91, 90, 90),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}