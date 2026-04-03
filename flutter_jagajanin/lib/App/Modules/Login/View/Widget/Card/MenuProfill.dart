import 'package:flutter/material.dart';

Widget buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF5E6278), size: 28),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xFF2D3142),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFF5E6278)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      shape: isLast 
        ? const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)))
        : null,
    );
  }

  Widget buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 20, 
      endIndent: 20,
      color: Colors.grey.shade100,
    );
  }