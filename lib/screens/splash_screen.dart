import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oru_copy/screens/home_page.dart';


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
    await Future.delayed(Duration(seconds: 3)); 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePageScreen()), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: Lottie.asset(
          'assets/animations/splash.json',
          
          
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
