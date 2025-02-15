import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class SocialMediaShare extends StatelessWidget {
  final String shareText = "Check out ORUphones app! #oruphones #usedphones #mobiledeals";

  const SocialMediaShare({super.key});

  void _shareToPlatform(String url, String fallbackText) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Share.share(fallbackText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _shareToPlatform("https://www.instagram.com/direct/new/?text=$shareText", shareText),
          child: Image.asset('assets/images/Group.png', height: 50),
        ),
        GestureDetector(
          onTap: () => _shareToPlatform("https://t.me/share/url?url=https://example.com&text=$shareText", shareText),
          child: Image.asset('assets/images/Group1.png', height: 50),
        ),
        GestureDetector(
          onTap: () => _shareToPlatform("https://twitter.com/intent/tweet?text=$shareText", shareText),
          child: Image.asset('assets/images/Group2.png', height: 50),
        ),
        GestureDetector(
          onTap: () => _shareToPlatform("https://wa.me/?text=$shareText", shareText),
          child: Image.asset('assets/images/Group3.png', height: 50),
        ),
      ],
    );
  }
}
