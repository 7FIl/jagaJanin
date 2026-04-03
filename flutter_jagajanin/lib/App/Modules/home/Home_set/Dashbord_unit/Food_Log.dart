import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Widget/Tools/Food_card.dart';

class FoodLog extends StatelessWidget {
  const FoodLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Panduan Makan"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: const Color.fromARGB(255, 101, 156, 251),
                    child: Icon(
                      Icons.rice_bowl,
                      color: Colors.blueAccent,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Makanan Pokok",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFFF48FB1),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/img/Nasi.png',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Nasi Putih",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "1 Centong",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  "Kkal: 300 gram",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  "Rp 1.500",
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      91,
                                      90,
                                      90,
                                    ),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color(0xFFF48FB1),
                    child: FaIcon(
                      FontAwesomeIcons.drumstickBite, 
                      color: Colors.red, 
                      size: 15,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Lauk Pauk",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: FoodCard(
                  foodName: "Ayam (Dada)",
                  Porsi: "1 Centong",
                  imagePath: "assets/img/Ayamm.png",
                  Ukuran: "Kkal: 300 gram",
                  Harga: "Rp 7.000",
                ),
              ),

              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: FoodCard(
                  foodName: "Tahu",
                  Porsi: "1 Centong",
                  imagePath: "assets/img/Tahu.png",
                  Ukuran: "Kkal: 300 gram",
                  Harga: "Rp 500",
                ),
              ),

              SizedBox(height: 20),
              Row(children: [
                SizedBox(width: 20),
                CircleAvatar(
                    radius: 17,
                    backgroundColor: Color(0x3343A047),
                    child: Icon(
                      Icons.eco,
                      color: Colors.green,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    "Sayuran",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
              ],),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: FoodCard(
                  foodName: "Sayur Tumis",
                  Porsi: "1 Centong",
                  imagePath: "assets/img/Salad.png",
                  Ukuran: "Kkal: 300 gram",
                  Harga: "Rp 2.500",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
