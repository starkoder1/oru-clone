import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:oru_copy/providers/login_provider.dart';
import 'package:oru_copy/widgets/bottom_sheets/name_bottom_sheet.dart';
import 'package:oru_copy/widgets/bottom_sheets/number_bottom_sheet.dart';
import 'package:oru_copy/widgets/bottom_sheets/otp_bottom_sheet.dart';

// Modify return type to Future<bool?> and return a result
Future<bool?> triggerLoginNavigation(BuildContext context, WidgetRef ref) async {
  final loginResult = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => NumberBottomSheet(),
  );

  if (loginResult == true) {
    ref.read(authProvider.notifier).generateOtp();

    final otpResult = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(16)),
      ),
      builder: (context) => const OtpBottomSheet(),
    );

    if (otpResult == true) {
      await showModalBottomSheet( // No need to await for NameBottomSheet itself to finish
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(16)),
        ),
        builder: (context) => NameBottomSheet(),
      );
      return true; // Return true if OTP and Name are successful (login flow completed)
    } else {
      return false; // Return false if OTP bottom sheet was not successful
    }
  } else {
    return false; // Return false if Number bottom sheet was not successful (cancelled)
  }
}