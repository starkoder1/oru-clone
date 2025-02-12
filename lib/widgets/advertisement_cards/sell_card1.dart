import 'package:flutter/material.dart';

class SellCard1 extends StatelessWidget {
  const SellCard1({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge, 
      elevation: 2.0,
      color: Colors.yellow.shade100, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), 
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect( 
              borderRadius: BorderRadius.circular(10.0), 
              child: Image.asset(
                'assets/images/Sell.png', 
                fit: BoxFit.cover,
                
                width: double.infinity, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}