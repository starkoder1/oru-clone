// mind_menu_item.dart
import 'package:flutter/material.dart';

class MindMenuItem extends StatelessWidget {
  final String imageAssetPath; // Changed to imageAssetPath
  final String text;
  final VoidCallback? onPressed;

  const MindMenuItem({
    super.key,
    required this.imageAssetPath, // Changed to imageAssetPath
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          iconSize: 40,
          icon: Image.asset( // Use Image.asset
            imageAssetPath,
            width: 100,
            height: 100,
          ),
          onPressed: onPressed,
        ),
        // const SizedBox(height: 5),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}