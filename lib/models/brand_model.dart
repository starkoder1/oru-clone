class Brand {
  final String name;
  final String imageUrl;

  Brand({required this.name, required this.imageUrl});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      name: json['name'] ?? '',
      imageUrl: json['image'] ?? '',
    );
  }
}
