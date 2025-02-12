import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:oru_copy/screens/name_screen.dart';
import 'package:oru_copy/screens/otp_screen.dart';
import 'package:oru_copy/screens/splash_screen.dart'; // Import NameScreen

void main() {
  runApp(
    const ProviderScope( // Wrap MyApp with ProviderScope
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home:  SplashScreen(), // Set NameScreen as home
    );
  }
}