import 'package:flutter/material.dart';

class SellCard2 extends StatelessWidget {
  const SellCard2({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge, 
      elevation: 2.0,
      color: Colors.yellow.shade200, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), 
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect( 
              borderRadius: BorderRadius.circular(10.0), 
              child: Image.asset(
                'assets/images/Compare.png', 
                fit: BoxFit.contain,
                height: 270, 
                width: double.infinity, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}