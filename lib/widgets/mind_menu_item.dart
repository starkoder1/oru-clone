
import 'package:flutter/material.dart';

class MindMenuItem extends StatelessWidget {
  final String imageAssetPath; 
  final String text;
  final VoidCallback? onPressed;

  const MindMenuItem({
    super.key,
    required this.imageAssetPath, 
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
          icon: Image.asset( 
            imageAssetPath,
            width: 100,
            height: 100,
          ),
          onPressed: onPressed,
        ),
        
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}