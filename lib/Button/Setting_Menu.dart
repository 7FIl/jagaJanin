import 'package:flutter/material.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Akun Anda')),

      body: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('A', style: TextStyle(color: Colors.white)),
            ),
            title: const Text(
              'Adriel',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              'Lihat profil',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.black),
            onTap: () {
              print('Buka halaman profil Adriel!');
            },
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
              child: Text(
                'Pengaturan Akun',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          MenuProfilCustom(
            nama: "Tambah Akun",
            onTap: () {
              print('Buka halaman tambah akun');
            },
          ),

          MenuProfilCustom(
            nama: "Logout",
            onTap: () {
              print('Logout');
            },
          ),
        ],
      ),
    );
  }
}

class MenuProfilCustom extends StatelessWidget {
  final String nama;
  final VoidCallback onTap;

  const MenuProfilCustom({super.key, required this.nama, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
      title: Text(
        nama,
        style: const TextStyle(
          color: Color.fromARGB(255, 23, 22, 22),
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black),
      onTap: onTap,
    );
  }
}
