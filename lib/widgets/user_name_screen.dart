import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:oru_copy/providers/name_provider.dart';
import 'package:oru_copy/screens/number_screen.dart';
// import 'package:oru_copy/providers/username_provider.dart'; // Import your usernameProvider

class NameScreenWidget extends ConsumerStatefulWidget {
  // Changed to ConsumerStatefulWidget and renamed to NameScreenWidget
  const NameScreenWidget({super.key});

  @override
  ConsumerState<NameScreenWidget> createState() =>
      _NameScreenState(); // Changed to ConsumerState
}

class _NameScreenState extends ConsumerState<NameScreenWidget> {
  // Changed to ConsumerState
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userNameNotifier = ref.watch(userNameProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Top Bar with Logo and Close Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 40), // Spacer to balance logo
            Image.asset(
              'assets/icons/Logo.png', // Adjust this path
              height: 50,
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black, size: 26),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        const SizedBox(height: 30),

        // Welcome Text
        const Text(
          'Welcome',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'SignUp to continue',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 40),

        // Name Input Field
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Please Tell Us Your Name *',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
        ),
        const SizedBox(height: 30),

        // Confirm Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: ()async {
              String userName = _nameController.text.trim();
              if (userName.isNotEmpty) {
                // **Update Riverpod StateProvider**
                final isUpdated = await userNameNotifier.updateUsername(
                  userName: _nameController.text.trim(), // **ONLY pass userName**
                );
                print('Username entered: $userName ');
              } else {
                print('Name field is empty.');
              }
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NumberScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Confirm Name',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
