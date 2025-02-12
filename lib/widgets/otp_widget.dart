import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oru_copy/providers/otp_provider.dart';

class OtpWidget extends ConsumerStatefulWidget {
  const OtpWidget({super.key});

  @override
  ConsumerState<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends ConsumerState<OtpWidget> {
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<String> _otpDigits = List.filled(4, ''); // Global list to store OTP digits

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          alignment: Alignment.center,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            onChanged: (value) {
              if (value.isNotEmpty) {
                // Update the global list with the new digit
                _otpDigits[index] = value;

                // Move focus to the next box if not the last one
                if (index < 3) {
                  FocusScope.of(context).nextFocus();
                }
              } else {
                // If the value is empty (deleted), clear the digit at this index
                _otpDigits[index] = '';

                // Move focus to the previous box if not the first one
                if (index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              }

              // Join the list into a single OTP string and update Riverpod
              String updatedOtp = _otpDigits.join();
              ref.read(otpProvider.notifier).state = updatedOtp;

              print("OTP updated: $updatedOtp"); // Debug print
            },
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      }),
    );
  }
}