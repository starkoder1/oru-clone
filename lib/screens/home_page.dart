import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oru_copy/navigation/bottom_sheet_navigation.dart';
import 'package:oru_copy/providers/login_provider.dart';
import 'package:oru_copy/providers/otp_provider.dart';
import 'package:oru_copy/providers/paginated_products_provider.dart';
import 'package:oru_copy/widgets/bottom_ui_widgets/offer_ui.dart';
import 'package:oru_copy/widgets/product_card_widgets/product_card_list_with_ads.dart';
import 'package:oru_copy/widgets/banner_widget.dart';
import 'package:oru_copy/widgets/brand_widgets/brand_list.dart';
import 'package:oru_copy/widgets/hamburger_menu.dart';
import 'package:oru_copy/widgets/horizontal_nav_btn.dart';
import 'package:oru_copy/widgets/bottom_sheets/number_bottom_sheet.dart';
import 'package:oru_copy/widgets/mind_menu_item.dart';
import 'package:oru_copy/widgets/bottom_sheets/name_bottom_sheet.dart';
import 'package:oru_copy/widgets/bottom_sheets/otp_bottom_sheet.dart';
import 'package:oru_copy/widgets/bottom_ui_widgets/faq_section.dart';
import 'package:oru_copy/widgets/sort_buttons.dart'; // Import FAQ Section

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({super.key});

  @override
  ConsumerState<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  final ScrollController _scrollController =
      ScrollController(); // ScrollController
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
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.1) {
      // Load next page when scrolled 80% of the way down
      if (!ref.read(paginatedProductProvider).isLoadingNextPage &&
          ref.read(paginatedProductProvider).hasMorePages) {
        ref.read(paginatedProductProvider.notifier).loadNextPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final globalIsLoggedIn = ref.watch(isLoggedInProvider);
    // Watch the Riverpod provider for the PaginatedProductState
    final productState = ref.watch(paginatedProductProvider);

    return Scaffold(backgroundColor: Colors.white,
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
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icons/Logo.png',
                    height: 30,
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
                    if (!globalIsLoggedIn)
                      ElevatedButton(
                        onPressed: () async {
                          await triggerLoginNavigation(context, ref);
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
                    if (globalIsLoggedIn)
                      Icon(Icons.notifications_none_outlined,
                          color: Colors.black),
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
                            buildNavButton("Get the App"),
                            
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
                                imageAssetPath: 'assets/icons/cart.png',
                                text: "Buy Used\nPhones",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/tag.png',
                                text: "Sell Used\nPhones",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/tags.png',
                                text: "Compare Prices",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/profile.png',
                                text: "My Profile",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/listing.png',
                                text: "My Listings",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/store.png',
                                text: "Open Store",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/cog.png',
                                text: "Services",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/health.png',
                                text: "Device Health\n Check",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/battery.png',
                                text: "Battery Health\n Check",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/sim.png',
                                text: "IMEI Verification",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/details.png',
                                text: "Device\n Details",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/gold.png',
                                text: "Data Wipe",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/badge.png',
                                text: "Under Warranty\n Phone",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/premuim.png',
                                text: "Premium\n Phones",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/like.png',
                                text: "Like New\n Phones",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/ref_phone.png',
                                text: "Refurbished\n Phones",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/check.png',
                                text: "Verified\n Phones",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/hand.png',
                                text: "My Negotiations",
                              ),
                              MindMenuItem(
                                imageAssetPath: 'assets/icons/heart_phone.png',
                                text: "My Favorites",
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
                        SortFilterButtons(),
                        // **Use productState.productList from Riverpod provider**
                        ProductListWithAds(products: productState.productList),
                        // **Loading indicator based on productState.isLoadingNextPage**
                        if (productState.isLoadingNextPage &&
                            productState.hasMorePages)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        // **Optional Error message display**
                        if (productState.error != null)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                                child: Text('Error: ${productState.error!}')),
                          ),
                        // ** ADD FAQ SECTION HERE **
                      ],
                    ),
                  ),
                  if (!productState.hasMorePages &&
                      productState.faqList.isNotEmpty)
                    FaqSection(faqQuestions: productState.faqList),
                  const OfferSubscriptionWidget(),
                  Image.asset('assets/images/Frame.png'),
                  Container(
                    margin: EdgeInsets.all(0),
                    color: const Color.fromRGBO(54, 54, 54, 1),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Invite a Friend",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 280,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        'assets/images/deal.png',
                        height: 220,
                      ),
                    ),
                    color: const Color.fromRGBO(54, 54, 54, 1),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  if (!productState.hasMorePages &&
                      productState.faqList.isNotEmpty)
                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Group.png',
                          height: 40,
                        ),
                        Image.asset(
                          'assets/images/Group1.png',
                          height: 40,
                        ),
                        Image.asset(
                          'assets/images/Group2.png',
                          height: 40,
                        ),
                        Image.asset(
                          'assets/images/Group3.png',
                          height: 40,
                        ),
                      ],
                    )
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
