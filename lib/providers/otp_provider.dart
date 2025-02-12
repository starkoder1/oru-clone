import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a StateProvider to manage the OTP string
final otpProvider = StateProvider<String>((ref) => '');