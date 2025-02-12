import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

// Provider for ProductService
final productServiceProvider = Provider<ProductService>((ref) => ProductService());

// StateNotifier for managing the list of products and its state
class ProductListNotifier extends StateNotifier<AsyncValue<List<ProductModel>>> {
  final ProductService _productService;

  ProductListNotifier(this._productService) : super(const AsyncValue.loading()) {
    fetchProducts(); // Fetch products immediately when the notifier is created
  }

  Future<void> fetchProducts() async {
    state = const AsyncValue.loading(); // Set state to loading when fetching starts
    try {
      final products = await _productService.fetchProducts();
      state = AsyncValue.data(products); // Set state to data with fetched products
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // Set state to error if fetching fails
    }
  }
}

// StateNotifierProvider for ProductListNotifier
final productListProvider = StateNotifierProvider<ProductListNotifier, AsyncValue<List<ProductModel>>>((ref) {
  final productService = ref.watch(productServiceProvider);
  return ProductListNotifier(productService);
});