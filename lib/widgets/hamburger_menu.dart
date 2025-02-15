import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oru_copy/providers/name_provider.dart';
import 'package:oru_copy/providers/otp_provider.dart';
import 'package:oru_copy/screens/number_screen.dart';


class HamburgerMenu extends ConsumerWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final userName = ref.watch(userNameProvider);

    return Drawer(
      child: Column(
        children: [
          // Top Logo Section
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/icons/Logo.png', height: 50),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Buttons Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                if (!isLoggedIn)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NumberScreen()),
                        );
                      },
                      child: Text(
                        "Login/SignUp",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                if (isLoggedIn)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      color: Colors.grey[300],
                      child: Row(
                        spacing: 10,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('assets/icons/Logo.png'),
                          ),
                          Text(
                            'Hi, $userName',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {}, // Replace with actual action
                    child: Text(
                      "Sell Your Phone",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () async {
                    await OtpAuthService().logoutAction(
                        ref); // Call logout action from OtpAuthService
                    Navigator.pop(context); // Close the drawer after logout
                  },
                  icon: Icon(Icons.logout),
                  label: Text("Logout"),
                ),
              ],
            ),
          ),

          // Spacer to push icons to the bottom
          Spacer(),

          // Bottom Menu Icons
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 48.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 10,
              children: [
                _buildMenuItem(Icons.shopping_cart, "How to Buy"),
                _buildMenuItem(Icons.attach_money, "How to Sell"),
                _buildMenuItem(Icons.book, "Oru Guide"),
                _buildMenuItem(Icons.info, "About Us"),
                _buildMenuItem(Icons.privacy_tip, "Privacy Policy"),
                _buildMenuItem(Icons.help, "FAQs"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(icon, size: 28),
            onPressed: () {}, // Void action for now
          ),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
