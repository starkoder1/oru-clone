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
  final OtpAuthService _otpAuthService = OtpAuthService();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _notificationService.requestPermissionAndSubscribe();
    final isLoggedInResponse = await _otpAuthService.isLoggedIn();

    if (isLoggedInResponse['isLoggedIn'] == true) {
      final userData = isLoggedInResponse['user'] as Map<String, dynamic>?;
      final mobileNumber = userData?['mobileNumber'] as String? ?? '';
      final userName = userData?['userName'] as String? ?? '';

      debugPrint('User Mobile Number: $mobileNumber');

      if (userName.isEmpty) {
        _navigateToScreen(const NameScreen());
      } else {
        _navigateToScreen(const HomePageScreen());
      }
    } else {
      _navigateToScreen(const HomePageScreen());
    }
  }

  void _navigateToScreen(Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
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
