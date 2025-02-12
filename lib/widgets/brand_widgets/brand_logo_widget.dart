import 'package:flutter/material.dart';
import 'package:oru_copy/models/brand_model.dart';


Widget brandLogoWidget(Brand brand) {
  return Column(
    children: [
      CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: brand.imagePath.isNotEmpty
            ? ClipRRect( // Clip the image to the circle shape
                borderRadius: BorderRadius.circular(30), // Circular border radius
                child: Image.network(
                  brand.imagePath,
                  fit: BoxFit.contain, // Ensure the image fits inside the circle
                  width: 60, 
                ),
              )
            : Center(
                child: Text(
                  brand.make.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
      ),
      const SizedBox(height: 5),
      Text(brand.make, style: const TextStyle(fontSize: 12)),
    ],
  );
}