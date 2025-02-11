import 'package:flutter/material.dart';
import 'package:oru_copy/widgets/banner_widget.dart';
import 'package:oru_copy/widgets/horizontal_nav_btn.dart';
import 'package:oru_copy/widgets/mind_menu_item.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            // This SliverAppBar will disappear on scroll.
            SliverAppBar(
              pinned: false,
              floating: true,
              snap: true,
              expandedHeight: 70.0, // Reduced expandedHeight to 60.0**
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  // TODO: Implement Hamburger menu action
                },
              ),
              title: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'oru',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    'PHONES',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              actions: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on_outlined,
                        color: Colors.black, size: 16),
                    const Text(
                      'India',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement Login action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade700,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                      ),
                      child: const Text('Login'),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                height: 140.0,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: 80.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search phones with make, model...',
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.mic_none,
                                      color: Colors.grey),
                                  onPressed: () {
                                    // TODO: Implement Voice Search
                                  },
                                ),
                              ],
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            buildNavButton('Sell Used Phones'),
                            const SizedBox(width: 10),
                            buildNavButton('Buy Used Phones'),
                            const SizedBox(width: 10),
                            buildNavButton('Compare Prices'),
                            const SizedBox(width: 10),
                            buildNavButton('My Profile'),
                            const SizedBox(width: 10),
                            buildNavButton('My Listings'),
                            const SizedBox(width: 10),
                            buildNavButton("Services"),
                            const SizedBox(width: 10),
                            buildNavButton("Register your Store"),
                            const SizedBox(width: 10),
                            buildNavButton("Get the App")
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        const SizedBox(
                          height: 230,
                          child: BannerCarousel(),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: const Text(
                            "What's on your mind?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 15),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/image.png',
                                text: "Buy Used\nPhones",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/image.png',
                                text: "Buy Used\nPhones",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/image.png',
                                text: "Buy Used\nPhones",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/image.png',
                                text: "Buy Used\nPhones",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/image.png',
                                text: "Buy Used\nPhones",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/image.png',
                                text: "Buy Used\nPhones",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: const Text(
                                "Top brands",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                              onPressed: () {
                                // TODO: Implement "See All Brands" action
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildBrandLogo('Apple'),
                              const SizedBox(width: 15),
                              _buildBrandLogo('MI'),
                              const SizedBox(width: 15),
                              _buildBrandLogo('SAMSUNG'),
                              const SizedBox(width: 15),
                              _buildBrandLogo('vivo'),
                              const SizedBox(width: 15),
                              _buildBrandLogo('realme'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: const Text(
                            "Best deals in India",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                                
                          ),
                        ),
                        const SizedBox(height: 300),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement Sell + action
        },
        backgroundColor: Colors.yellow.shade700,
        foregroundColor: const Color.fromARGB(255, 142, 142, 142),
        label: const Text('Sell +', style: TextStyle(fontSize: 18)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildBrandLogo(String brandName) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade200,
          child: Center(
            child: Text(
              brandName.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(brandName, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  
}

// A custom delegate to create a pinned persistent header.
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget child;

  _SliverAppBarDelegate({required this.height, required this.child});

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}
