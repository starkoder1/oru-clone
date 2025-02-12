import 'package:flutter/material.dart';
import 'package:oru_copy/screens/name_screen.dart';
import 'package:oru_copy/screens/number_screen.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Top Logo Section
          SizedBox(
            height: 50,
          ),
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
                        MaterialPageRoute(builder: (context) => NumberScreen()),
                      );
                    }, // Replace with actual action
                    child: Text(
                      "Login/SignUp",
                      style: TextStyle(color: Colors.white),
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
