import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a StateProvider to store the username
final usernameProvider = StateProvider<String>((ref) => '');