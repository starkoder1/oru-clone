// lib/providers/paginated_product_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oru_copy/models/product_model.dart';
import 'package:oru_copy/services/product_service.dart'; // Import your ProductService
import '../models/faq_model.dart'; // Import FaqModel

// State class to hold the pagination state
class PaginatedProductState {
  final List<ProductModel> productList;
  final int page;
  final bool isLoadingNextPage;
  final bool hasMorePages;
  final String? error;
  // NEW PROPERTIES for FAQ
  final List<FaqModel> faqList;
  final bool isFaqLoading;
  final String? faqError;

  PaginatedProductState({
    this.productList = const [],
    this.page = 1,
    this.isLoadingNextPage = false,
    this.hasMorePages = true,
    this.error,
    // Initialize FAQ properties
    this.faqList = const [],
    this.isFaqLoading = false,
    this.faqError,
  });

  PaginatedProductState copyWith({
    List<ProductModel>? productList,
    int? page,
    bool? isLoadingNextPage,
    bool? hasMorePages,
    String? error,
    // CopyWith for FAQ properties
    List<FaqModel>? faqList,
    bool? isFaqLoading,
    String? faqError,
  }) {
    return PaginatedProductState(
      productList: productList ?? this.productList,
      page: page ?? this.page,
      isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
      hasMorePages: hasMorePages ?? this.hasMorePages,
      error: error ?? this.error,
      // Copy FAQ properties
      faqList: faqList ?? this.faqList,
      isFaqLoading: isFaqLoading ?? this.isFaqLoading,
      faqError: faqError ?? this.faqError,
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

    // Show loading indicator while fetching
    state = state.copyWith(isLoadingNextPage: true, error: null);

    try {
      final newProducts = await productService.fetchProducts(page: state.page);

      if (newProducts.isNotEmpty) {
        // Append the new products and update page count.
        state = state.copyWith(
          productList: [...state.productList, ...newProducts],
          page: state.page + 1,
          isLoadingNextPage: false,
          hasMorePages: newProducts.length >= 10 && state.page <= 10,
          error: null,
        );
      } else {
        // No products returned: stop loading and mark that there are no more pages.
        state = state.copyWith(
          isLoadingNextPage: false,
          hasMorePages: false,
          error: null,
          isFaqLoading: true, // Start FAQ loading if needed
          faqError: null,
        );
        // Fetch FAQs as a fallback when no more products exist.
        final faqData = await productService.fetchFAQs();
        state = state.copyWith(
          faqList: faqData,
          isFaqLoading: false,
          faqError: faqData.isEmpty ? 'Failed to load FAQs' : null,
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
