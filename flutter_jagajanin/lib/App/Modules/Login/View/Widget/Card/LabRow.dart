import 'package:flutter/material.dart';

Widget buildLabRow(String title, String value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          RichText(
            text: TextSpan(
              style: TextStyle(color: Color(0xFFF06292), fontSize: 16, ),
              children: [
                TextSpan(text: value),
                TextSpan(
                  text: unit,
                  style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }