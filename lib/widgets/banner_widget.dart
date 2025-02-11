// banner_carousel.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  final List<String> _bannerImagePaths = [
    // Moved banner paths to state for cleaner dot logic
    'assets/banners/cash_phone.png',
    'assets/banners/register_banner.png',
    'assets/banners/cash_phone.png',
    'assets/banners/register_banner.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: false,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: _bannerImagePaths.map((imagePath) {
            // Use _bannerImagePaths directly
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              _buildDotIndicators(), // Use a separate method for dot indicators
        ),
      ],
    );
  }

  List<Widget> _buildDotIndicators() {
    List<Widget> dots = [];
    for (int i = 0; i < _bannerImagePaths.length; i++) {
      dots.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Icon(
            _current == i
                ? Icons.circle
                : Icons.circle_outlined, // Use Material Icons
            color: _current == i ? Colors.grey.shade900 : Colors.grey.shade400,
            size: 10.0, // Adjust size as needed
          ),
        ),
      );
    }
    return dots;
  }
}
