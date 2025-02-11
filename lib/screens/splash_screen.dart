import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oru_copy/screens/home_page.dart';
// import 'package:your_app/main_screen.dart'; // Replace with your main screen import

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3)); // Adjust based on animation length
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePageScreen()), // Replace with your main screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Adjust background color as needed
      body: Center(
        child: Lottie.asset(
          'assets/animations/splash.json',
          // width: 300,
          // height: 300,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
