import 'package:flutter/material.dart';
import 'package:oru_copy/screens/otp_screen.dart';
import 'package:oru_copy/providers/login_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumberScreen extends ConsumerStatefulWidget {
  const NumberScreen({super.key});

  @override
  ConsumerState<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends ConsumerState<NumberScreen> {
  final TextEditingController phoneController = TextEditingController();

  void _submit() {
    if (phoneController.text.length == 10) {
      // Pop this bottom sheet with a result (e.g., true)
      
      Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isChecked = ref.watch(termsAcceptedProvider);
    // final isChecked = ref.watch(termsAcceptedProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Sign in to continue",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Enter Your Phone Number",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  onChanged: (value) =>
                      ref.read(phoneNumberProvider.notifier).state = value,
                  decoration: InputDecoration(
                    prefixText: "+91 ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    counterText: "",
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        // Only update the state for the checkbox, not for the phone number
                        ref.read(termsAcceptedProvider.notifier).state = value!;
                      },
                    ),
                    const Text(
                      "Accept ",
                      style: TextStyle(fontSize: 14),
                    ),
                    const Text(
                      "Terms and Conditions",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
