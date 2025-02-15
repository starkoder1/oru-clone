import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oru_copy/screens/home_page.dart';
import 'package:oru_copy/screens/name_screen.dart';
import 'package:oru_copy/services/notification_service.dart';
import 'package:oru_copy/providers/otp_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Check if the FCM token is already stored (e.g., check shared preferences or Firebase)
    // If not, request permission and subscribe to topics
    await _notificationService.requestPermissionAndSubscribe();

    final otpAuthService = OtpAuthService();
    final isLoggedInResponse =
        await otpAuthService.isLoggedIn();

    if (isLoggedInResponse['isLoggedIn'] == true) {
      final userData = isLoggedInResponse['user'] as Map<String, dynamic>?; 
      final mobileNumber = userData?['mobileNumber'] as String? ?? '';
      final userName = userData?['userName'] as String? ?? '';

      print('User Mobile Number: $mobileNumber');

      // If userName is empty, navigate to name screen, else home screen
      if (userName.isEmpty) {
        _navigateToConfirmNameScreen();
      } else {
        _navigateToHomeScreen();
      }
    } else {
      _navigateToHomeScreen();
    }
  }

  void _navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomePageScreen()),
    );
  }

  void _navigateToConfirmNameScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => NameScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset('assets/animations/splash.json', fit: BoxFit.contain),
      ),
    );
  }
}
