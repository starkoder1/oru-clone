import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oru_copy/navigation/bottom_sheet_navigation.dart';
import 'package:oru_copy/services/fav_listing_service.dart';
import 'package:oru_copy/providers/otp_provider.dart';

class LikeButtonWidget extends ConsumerStatefulWidget {
  final String listingId;
  final VoidCallback onLoginRequired;

  const LikeButtonWidget({
    super.key,
    required this.listingId,
    required this.onLoginRequired,
  });

  @override
  ConsumerState<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends ConsumerState<LikeButtonWidget> {
  bool _isLiked = false;
  @override
  void initState() {
    super.initState();
    // final globalIsLoggedIn = ref.watch(isLoggedInProvider);
    _checkIfLikedInitially();
  }

  void _checkIfLikedInitially() {
    if (globalFavListings != null &&
        globalFavListings!.contains(widget.listingId)) {
      setState(() {
        _isLiked = true;
      });
    } else {
      setState(() {
        _isLiked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   final globalIsLoggedIn = ref.watch(isLoggedInProvider);
    return IconButton(
      icon: Icon(
        _isLiked ? Icons.favorite : Icons.favorite_border,
        color: _isLiked ? Colors.red : null,
      ),
      onPressed: () async {
        if (_isLiked) {
          // **NEW CHECK: If already liked, do nothing and return**
          print(
              ">>> ListingId: ${widget.listingId} is already liked. Doing nothing on tap.");
          return; // Simply return if already liked, no API call, no state change
        }

        if (!globalIsLoggedIn) {
          print(">>> User not logged in. Triggering login flow.");
          bool? loginSuccessful = await triggerLoginNavigation(context, ref);

          if (loginSuccessful == true) {
            print(
                ">>> Login successful after Like button press. Proceeding to like listing.");
            _likeListing();
          } else {
            print(">>> Login flow cancelled or failed. Like action aborted.");
          }
          return;
        }

        _likeListing();
      },
    );
  }

  Future<void> _likeListing() async {
    final listingService = ListingService();
    final listingId = widget.listingId;

    print(">>> Liking listingId: $listingId (API call)");

    final result =
        await listingService.addListingToFavorites(listingId: listingId);

    if (result['success'] == true) {
      print(">>> Listing ID: $listingId added to favorites successfully!");
      setState(() {
        _isLiked =
            true; // **Crucially, ONLY set _isLiked to true, don't toggle back to false on "success" anymore**
      });
      // TODO: Optionally update global favListings in a user provider
    }
  }
}
