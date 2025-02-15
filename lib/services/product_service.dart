import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oru_copy/models/faq_model.dart';
import '../models/product_model.dart';

class ProductService {
    // API base URL - No change
    final String baseUrl = 'http://40.90.224.241:5000';

    Future<List<ProductModel>> fetchProducts({int page = 1}) async {
        final Uri uri = Uri.parse('$baseUrl/filter');

        try {
            final response = await http.post(
                uri,
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({
                    "filter": {
                        "condition": [],
                        "make": [],
                        "storage": [],
                        "ram": [],
                        "warranty": [],
                        "priceRange": [],
                        "sort": {},
                        "page": page
                    }
                }),
            );

            print('API Response Body (Page: $page): ${response.body}');
            print('API Response Status Code (Page $page): ${response.statusCode}');

            if (response.statusCode == 200) {
                final Map<String, dynamic> jsonData = jsonDecode(response.body);

                print('Decoded jsonData (Page $page): $jsonData'); // Debug: Print jsonData

                if (jsonData['data'] != null) {
                    print('Type of jsonData["data"] (Page $page): ${jsonData['data'].runtimeType}'); // Debug: Print type of jsonData['data']
                } else {
                    print('jsonData["data"] is null for Page $page'); // Debug: jsonData['data'] is null
                }

                if (jsonData['data'] != null && jsonData['data'] is Map) {
                    if (jsonData['data']['data'] != null) {
                         print('Type of jsonData["data"]["data"] (Page $page): ${jsonData['data']['data'].runtimeType}'); // Debug: Print type of jsonData['data']['data']
                    } else {
                         print('jsonData["data"]["data"] is null for Page $page'); // Debug: jsonData['data']['data'] is null
                    }
                }


                if (jsonData['data'] != null && jsonData['data'] is Map && jsonData['data']['data'] is List) {
                    final List<dynamic> productJsonList = jsonData['data']['data'];
                    return productJsonList
                        .map((json) => ProductModel.fromJson(json))
                        .toList();
                } else {
                    print('Warning: API response structure might be unexpected for page $page. "data" is not a Map or "data.data" is not a list.');
                    return [];
                }

            } else {
                print('Failed to fetch products for page $page. Status Code: ${response.statusCode}');
                print('Response Body: ${response.body}');
                return [];
            }
        } catch (e) {
            print('Error fetching products for page $page: $e');
            return [];
        }
    }
     Future<List<FaqModel>> fetchFAQs() async {
    final String faqEndpoint = 'http://40.90.224.241:5000/faq'; // FAQ API endpoint
    final Uri faqUri = Uri.parse(faqEndpoint);

    try {
      final response = await http.get(faqUri); // Make a GET request to the FAQ endpoint

      print('FAQ API Response Status Code: ${response.statusCode}');
      print('FAQ API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);

        if (jsonData is Map<String, dynamic> && jsonData['FAQs'] is List) {
          final List<dynamic> faqJsonList = jsonData['FAQs'];
          return faqJsonList.map((json) => FaqModel.fromJson(json)).toList();
        } else {
          print('Warning: Unexpected FAQ API response structure.');
          return []; // Return empty list if structure is not as expected
        }
      } else {
        print('Failed to fetch FAQs. Status Code: ${response.statusCode}');
        return []; // Return empty list if API call fails
      }
    } catch (e) {
      print('Error fetching FAQs: $e');
      return []; // Return empty list on error
    }
  }
}