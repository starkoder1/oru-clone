import 'package:flutter/material.dart';

class SortFilterButtons extends StatelessWidget {
  const SortFilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildButton(Icons.swap_vert, "Sort"),
        SizedBox(width: 10),
        _buildButton(Icons.tune, "Filters"),
      ],
    );
  }

  Widget _buildButton(IconData icon, String label) {
    return OutlinedButton.icon(
      onPressed: () {}, // Void action for now
      icon: Icon(icon, color: Colors.black),
      label: Text(label, style: TextStyle(color: Colors.black)),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: Colors.grey.shade300),
        backgroundColor: Colors.white,
      ),
    );
  }
}

