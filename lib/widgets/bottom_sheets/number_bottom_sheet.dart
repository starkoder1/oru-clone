import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:oru_copy/providers/login_provider.dart';

class NumberBottomSheet extends ConsumerWidget {
   NumberBottomSheet({super.key});

    final phoneControllerProvider = Provider((ref) => TextEditingController());
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create a provider for TextEditingController that doesn't auto-dispose
    final phoneController = ref.watch(phoneControllerProvider);
    final isChecked = ref.watch(termsAcceptedProvider);

    void _submit() {
      if (phoneController.text.length == 10) {
        // Pop this bottom sheet with a result (e.g., true)
        Navigator.pop(context, true);
      }
    }

    return Padding(
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
    );
  }
}
