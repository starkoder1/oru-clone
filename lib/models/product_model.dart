class ProductModel {
  final String id;
  final String title;
  final String storage;
  final String ram;
  final String condition;
  final double currentPrice;
  final double originalPrice;
  final double discountPercentage;
  final String location;
  final String datePosted;
  final String? thumbnailUrl;
  final bool isNegotiable;
  final bool isVerified;

  ProductModel({
    required this.id,
    required this.title,
    required this.storage,
    required this.ram,
    required this.condition,
    required this.currentPrice,
    required this.originalPrice,
    required this.discountPercentage,
    required this.location,
    required this.datePosted,
    this.thumbnailUrl,
    this.isNegotiable = false,
    this.isVerified = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as List? ?? []; // Safe cast and null check for images array
    String? thumbImageUrl;
    if (images.isNotEmpty) {
      thumbImageUrl = (images[0] as Map?)?['thumbImage'] as String?; // Get thumbImage from the first image, with null checks
    }

    double originalPriceValue = 0.0;
    double discountedPriceValue = 0.0;
    double discountPercentageValue = 0.0;

    if (json['originalPrice'] != null) {
      originalPriceValue = double.tryParse(json['originalPrice'].toString()) ?? 0.0;
    }
    if (json['discountedPrice'] != null) {
      discountedPriceValue = double.tryParse(json['discountedPrice'].toString()) ?? 0.0;
    }
    if (json['discountPercentage'] != null) {
      discountPercentageValue = double.tryParse(json['discountPercentage'].toString()) ?? 0.0;
    }

    return ProductModel(
      id: json['_id']?.toString() ?? '',
      title: json['marketingName'] ?? 'Product Title',
      storage: json['deviceStorage'] ?? '',
      ram: json['deviceRam'] == '--' ? 'N/A' : json['deviceRam'] ?? 'N/A', // Handle "--" as N/A
      condition: json['deviceCondition'] ?? '',
      currentPrice: double.tryParse(json['listingPrice'].toString())?.toDouble() ?? 0.0, // Parse as double
      originalPrice: originalPriceValue,
      discountPercentage: discountPercentageValue,
      location: json['listingLocality'] ?? '',
      datePosted: json['listingDate'] ?? '',
      thumbnailUrl: thumbImageUrl,
      isNegotiable: json['openForNegotiation'] ?? false,
      isVerified: json['verified'] ?? false,
    );
  }
}