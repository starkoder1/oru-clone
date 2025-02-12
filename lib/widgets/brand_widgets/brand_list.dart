import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oru_copy/models/brand_model.dart';
import 'package:oru_copy/providers/brand_logo_provider.dart';
import 'package:oru_copy/widgets/brand_widgets/brand_logo_widget.dart';


class BrandListWidget extends ConsumerWidget {
  const BrandListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandListAsyncValue = ref.watch(brandProvider);

    return brandListAsyncValue.when(
      data: (brands) => _buildBrandList(brands), 
      loading: () => const Center(child: CircularProgressIndicator()), 
      error: (error, stackTrace) => Center(child: Text('Error: ${error.toString()}')), 
    );
  }

  Widget _buildBrandList(List<Brand> brands) {
    return ListView.builder( 
      scrollDirection: Axis.horizontal, 
      itemCount: brands.length,
      itemBuilder: (context, index) {
        return Padding( 
          padding: const EdgeInsets.symmetric(horizontal: 15.0), 
          child: brandLogoWidget(brands[index]),
        );
      },
    );
  }
}