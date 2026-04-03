import 'package:flutter/material.dart';

Widget buildTabItem(String label, bool isActive, {VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isActive 
          ? [BoxShadow(color: Colors.black12, blurRadius: 4)] 
          : [],
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.pink.shade200 : Colors.blueGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}