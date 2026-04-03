import 'package:flutter/material.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Widget/Card/jadwalKonsultasiCard.dart';
import 'package:flutter_jagajanin/App/Modules/Login/View/Widget/Card/DokterCard.dart';

class Konsultasi extends StatefulWidget {
  const Konsultasi({super.key});

  @override
  State<Konsultasi> createState() => _KonsultasiState();
}

class _KonsultasiState extends State<Konsultasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "Temukan dokter untuk konsultasi kesehatan kehamilan",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Dokter Spesialis',
                    hintStyle: const TextStyle(
                      color: Color(0xFF7E8CA0),
                      fontSize: 16,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF7E8CA0),
                      size: 25,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Jadwal Konsultasi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    Text(
                      'Lihat semua',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFE594AB), // Warna pink
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              JadwalKonsultasiCard(
                tanggal: 'Rabu, 13 April 2026',
                dokter: 'Dr. Iwan, SpOG',
              ),

              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Rekomendasi Dokter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    Text(
                      'Lihat semua',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFE594AB), // Warna pink
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              DoctorCard(
                nama: 'Dr. Iwan, SpOG',
                spesialis: 'Obgyn',
                pengalaman: '12',
                tarif: '50.000',
                fotoUrl: 'assets/img/Dokter.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
