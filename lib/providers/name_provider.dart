import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oru_copy/providers/otp_provider.dart'; // Import OtpAuthService and globalCsrfToken
import 'dart:convert'; // Import dart:convert for jsonEncode/decode
import 'package:http/http.dart' as http; // Import http package

late final String decodedCookie;

// Simplified username provider - managing just a String state
class UsernameNotifier extends StateNotifier<String> {
  // final OtpAuthService _authService;
  final Ref ref;

  UsernameNotifier({required this.ref}) : super('');
  String extractSessionCookie(String rawCookie) {
    // This regex extracts the session token up to the first semicolon.
    final match = RegExp(r'session=([^;]+)').firstMatch(rawCookie);
    if (match != null) {
      // Decode the URL-encoded session value
      final encodedValue = match.group(1)!;
      final decodedValue = Uri.decodeComponent(encodedValue);
      decodedCookie = decodedValue;
      return 'session=$decodedValue';
    }
    return '';
  }


  Future<bool> updateUsername({required String userName}) async {
    final countryCode = 91;
    final baseUrl = 'http://40.90.224.241:5000';
    final Uri uri = Uri.parse('$baseUrl/update');
// Function to extract only the session ID from globalCookie
    final headers = {
      'Content-Type': 'application/json',
      'X-Csrf-Token':
          globalCsrfToken ?? '', // Use the exact header key as in Postman
      'Cookie': extractSessionCookie(globalCookie ?? ''),
    };

    print(">>> UsernameNotifier.updateUsername API Call Started!");
    print(">>> API Endpoint: $uri");
    print(">>> Updating Username to: $userName");
    print(">>> API Headers: $headers");

    try {
      final response = await http.post(
        uri,
        headers: headers,
        
        body: jsonEncode({
          "countryCode": countryCode,
          "userName": userName,
        }),
      );

      print(">>> UsernameNotifier.updateUsername API Response Received!");
      print(">>> Response Status Code: ${response.statusCode}");
      print(">>> Response Body: ${response.body}");

      final decodedResponse = json.decode(response.body);
      if (decodedResponse['status'] == 'SUCCESS') {
        state = userName;
        print(">>> Username updated successfully via API and provider.");
        return true;
      } else {
        print(
            ">>> Username update FAILED via API. Reason: ${decodedResponse['reason']}");
        return false;
      }
    } catch (e) {
      print('Error updating username (in provider): $e');
      return false;
    }
  }

  String get currentUsername => state;
}

final userNameProvider = StateNotifierProvider<UsernameNotifier, String>(
  (ref) => UsernameNotifier(ref: ref),
);
