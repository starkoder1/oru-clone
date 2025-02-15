import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oru_copy/widgets/otp_widget.dart';
import 'package:oru_copy/providers/login_provider.dart';
import 'package:oru_copy/providers/otp_provider.dart';

class OtpBottomSheet extends ConsumerStatefulWidget {
  const OtpBottomSheet({super.key});

  @override
  ConsumerState<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends ConsumerState<OtpBottomSheet> {
  bool _isValidatingOtp = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16, // Moves sheet up with keyboard
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Verify OTP',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Please enter the 4-digit verification code sent to your mobile number.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const OtpWidget(), // Keeps your OTP input widget
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade700,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _isValidatingOtp
                  ? null
                  : () async {
                      print(">>> Validate OTP Button Pressed in OtpBottomSheet!");
                      final mobileNumber = ref.read(phoneNumberProvider);
                      final otp = ref.read(otpProvider);
            
                      print(">>> Mobile Number from Provider: $mobileNumber");
                      print(">>> OTP from Provider: $otp");
            
                      if (otp.isNotEmpty) {
                        setState(() {
                          _isValidatingOtp = true;
                        });
            
                        print(">>> Calling validateOtpAction...");
                        await validateOtpAction(mobileNumber: mobileNumber, otp: otp, ref: ref);
                        print(">>> validateOtpAction COMPLETED.");
            
                        setState(() {
                          _isValidatingOtp = false;
                        });
            
                        Navigator.of(context).pop(true);
                      } else {
                        print('Please enter OTP');
                      }
                    },
              child: _isValidatingOtp
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Verify OTP',style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
