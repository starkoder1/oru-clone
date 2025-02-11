 import 'package:flutter/material.dart';

Widget buildNavButton(String text) {
    return OutlinedButton(
      onPressed: () {
        // TODO: Implement Navigation Button action for $text
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Example radius
        ),
        side: BorderSide(color: Colors.grey.shade300), // Example border color
      ),
      child: Text(text, style: const TextStyle(color: Colors.black)),
    );
  }