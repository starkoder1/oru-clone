import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oru_copy/providers/otp_provider.dart'; // For globalCsrfToken and globalCookie

class ListingService {
  final String baseUrl = 'http://40.90.224.241:5000';

  Future<Map<String, dynamic>> addListingToFavorites({required String listingId}) async {
    // **UPDATED API ENDPOINT TO /favs:**
    final Uri uri = Uri.parse('$baseUrl/favs');

    print(">>> ListingService.addListingToFavorites API Call Started!");
    print(">>> API Endpoint: $uri");
    print(">>> Adding listingId to favorites: $listingId");

    final headers = {
      'Content-Type': 'application/json',
      'X-Csrf-Token': globalCsrfToken ?? '',
      'Cookie': globalCookie ?? '',
    };
    print(">>> ListingService.addListingToFavorites API Headers: $headers");

    try {
      final response = await http.post(
        uri,
        headers: headers,
        // **UPDATED REQUEST BODY TO INCLUDE "isFav": true:**
        body: jsonEncode({
          "listingId": listingId,
          "isFav": true, // **IMPORTANT: Set isFav to true to ADD to favorites**
        }),
      );

      print(">>> ListingService.addListingToFavorites API Response Received!");
      print(">>> Response Status Code: ${response.statusCode}");
      print(">>> Response Body: ${response.body}");

      final decodedResponse = json.decode(response.body);
      return decodedResponse;

    } catch (e) {
      print('Error adding listing to favorites (in ListingService): $e');
      return {'status': 'FAILED', 'reason': 'Network error'};
    }
  }
}