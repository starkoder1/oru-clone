import 'package:flutter_riverpod/flutter_riverpod.dart';

// Phone Number Provider
final phoneNumberProvider = StateProvider<String>((ref) => "");

// Checkbox State Provider
final termsAcceptedProvider = StateProvider<bool>((ref) => false);
