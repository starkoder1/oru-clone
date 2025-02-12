import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/brand_model.dart';

class ApiService {
  static const String baseUrl = "http://40.90.224.241:5000";

  Future<List<Brand>> fetchBrands() async {
    final response = await http.get(Uri.parse('$baseUrl/makeWithImages'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Brand.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load brands");
    }
  }
}
