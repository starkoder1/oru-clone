// lib/providers/paginated_product_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oru_copy/models/product_model.dart';
import 'package:oru_copy/services/product_service.dart'; // Import your ProductService

// State class to hold the pagination state
class PaginatedProductState {
  final List<ProductModel> productList;
  final int page;
  final bool isLoadingNextPage;
  final bool hasMorePages;
  final String? error;

  PaginatedProductState({
    this.productList = const [], // Initialize with empty product list
    this.page = 1, // Start at page 1
    this.isLoadingNextPage = false,
    this.hasMorePages = true,
    this.error,
  });

  PaginatedProductState copyWith({
    List<ProductModel>? productList,
    int? page,
    bool? isLoadingNextPage,
    bool? hasMorePages,
    String? error,
  }) {
    return PaginatedProductState(
      productList: productList ?? this.productList,
      page: page ?? this.page,
      isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
      hasMorePages: hasMorePages ?? this.hasMorePages,
      error: error ?? this.error,
    );
  }
}

// StateNotifier to manage the paginated product state
class PaginatedProductNotifier extends StateNotifier<PaginatedProductState> {
  final ProductService productService; // Dependency on ProductService

  PaginatedProductNotifier({required this.productService})
      : super(PaginatedProductState());

  Future<void> loadNextPage() async {
    if (state.isLoadingNextPage || !state.hasMorePages) return;

    state = state.copyWith(isLoadingNextPage: true, error: null);

    try {
      final newProducts = await productService.fetchProducts(page: state.page);

      if (newProducts.isNotEmpty) {
        state = state.copyWith(
          productList: [...state.productList, ...newProducts],
          page: state.page + 1,
          isLoadingNextPage: false,
          hasMorePages: newProducts.length >= 10 &&
              state.page <= 10, // Adjusted to 10 items per page
          error: null,
        );
      } else {
        state = state.copyWith(
          isLoadingNextPage: false,
          hasMorePages: false,
          error: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingNextPage: false,
        hasMorePages: false,
        error: 'Failed to load products: $e',
      );
      print('Error loading page ${state.page}: $e');
    }
  }
}

// Riverpod Provider for PaginatedProductNotifier
final paginatedProductProvider =
    StateNotifierProvider<PaginatedProductNotifier, PaginatedProductState>(
  (ref) => PaginatedProductNotifier(productService: ProductService()),
);
