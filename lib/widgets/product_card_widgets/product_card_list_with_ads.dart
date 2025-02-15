import 'package:flutter/material.dart';
import 'package:oru_copy/models/product_model.dart';
import 'package:oru_copy/widgets/advertisement_cards/sell_card1.dart'; // Assuming SellCard1 is your AdWidgetType1
import 'package:oru_copy/widgets/advertisement_cards/sell_card2.dart';
import 'product_card_widget.dart';

class ProductListWithAds extends StatelessWidget {
  final List<ProductModel> products;

  const ProductListWithAds({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: Text('No products available.')),
      );
    }

    List<Widget> items = [];
    int adCardType = 0; // 0 for SellCard1, 1 for SellCard2

    for (int index = 0; index < products.length; index++) {
      items.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
        child: ProductCardWidget(product: products[index]),
      ));

      if ((index + 1) % 7 == 0 && (index + 1) <= products.length) { // Display ad after every 2 products instead of 7 as per new request
        // Alternate between SellCard1 and SellCard2
        if (adCardType == 0) {
          items.add(const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
            child: SellCard1(), // Use SellCard1 as one ad type
          ));
          adCardType = 1; // Next ad will be SellCard2
        } else {
          items.add(const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
            child: SellCard2(), // Use SellCard2 as the other ad type
          ));
          adCardType = 0; // Next ad will be SellCard1
        }
      }
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return items[index];
      },
    );
  }
}