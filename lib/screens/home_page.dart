import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oru_copy/providers/paginated_products_provider.dart';
import 'package:oru_copy/widgets/product_card_widgets/product_card_list_with_ads.dart';
import 'package:oru_copy/widgets/banner_widget.dart';
import 'package:oru_copy/widgets/brand_widgets/brand_list.dart';
import 'package:oru_copy/widgets/hamburger_menu.dart';
import 'package:oru_copy/widgets/horizontal_nav_btn.dart';
import 'package:oru_copy/widgets/bottom_sheets/number_bottom_sheet.dart';
import 'package:oru_copy/widgets/mind_menu_item.dart';
import 'package:oru_copy/widgets/bottom_sheets/name_bottom_sheet.dart';
import 'package:oru_copy/widgets/bottom_sheets/otp_bottom_sheet.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({super.key});

  @override
  ConsumerState<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  final ScrollController _scrollController = ScrollController(); // ScrollController

  @override
  void initState() {
    super.initState();
    // Initial load is triggered by provider automatically on first watch
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Load next page using the Riverpod Notifier
      ref.read(paginatedProductProvider.notifier).loadNextPage(); // Use Riverpod to call loadNextPage
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the Riverpod provider for the PaginatedProductState
    final productState = ref.watch(paginatedProductProvider);

    return Scaffold(
      drawer: HamburgerMenu(),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            // AppBar (disappears on scroll) - unchanged
            SliverAppBar(
              pinned: false,
              floating: true,
              snap: true,
              expandedHeight: 70.0,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
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
                      onPressed: () async {
                        final loginResult = await showModalBottomSheet<bool>(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          builder: (context) => NumberBottomSheet(),
                        );

                        if (loginResult == true) {
                          final otpResult = await showModalBottomSheet<bool>(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            builder: (context) => const OtpBottomSheet(),
                          );

                          if (otpResult == true) {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16)),
                              ),
                              builder: (context) => NameBottomSheet(),
                            );
                          }
                        }
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
            // Persistent Header (stays at top) - unchanged
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
            // Product List and Ads (using ProductListWithAds widget)
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
                              icon: const Icon(Icons.arrow_forward_ios, size: 16),
                              onPressed: () {
                                // TODO: Implement "See All Brands" action
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 100,
                          child: BrandListWidget(),
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
                        const SizedBox(height: 10),
                        // **Use productState.productList from Riverpod provider**
                        ProductListWithAds(products: productState.productList),
                        // **Loading indicator based on productState.isLoadingNextPage**
                        if (productState.isLoadingNextPage && productState.hasMorePages)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        // **Optional Error message display**
                        if (productState.error != null)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(child: Text('Error: ${productState.error!}')),
                          ),
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

  
}


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