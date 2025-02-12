class Brand {
  final String make;
  final String imagePath;

  Brand({required this.make, required this.imagePath});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      make: json['make'],
      imagePath: json['imagePath'],
    );
  }
}
