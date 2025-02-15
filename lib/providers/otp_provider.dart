import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final otpProvider = StateProvider<String>((ref) => "");

String? globalUserName;
List<String>? globalFavListings;
String? globalCookie;
String? globalCsrfToken;
String? globalSessionId;
final isLoggedInProvider = StateProvider<bool>((ref) => false);

class OtpAuthService {
  final String baseUrl = 'http://40.90.224.241:5000';
Future<Map<String, dynamic>> logout() async {
    final Uri uri = Uri.parse('$baseUrl/logout');

    
    const hardcodedSessionCookie = "session=s%3A67a78ff9138e36a3f776780c.pduCbRJwYzKophKGclFKdWjJbWBVqrmobWnx%2FCYaE3o";

    final headers = {
      'Cookie': hardcodedSessionCookie, 
      'X-Csrf-Token': globalCsrfToken ?? '', 
    };
    print(">>> logout API Endpoint (Hardcoded Cookie): $uri");
    print(">>> logout API Headers (Hardcoded Cookie): $headers");

    try {
      final response = await http.get(
        uri,
        headers: headers,
    );

      final decodedResponse = json.decode(response.body);

      // ** Debugging for logout API **
      print(">>> logout API Response Status Code (Hardcoded Cookie): ${response.statusCode}");
      print(">>> logout API Response Body (Hardcoded Cookie): ${response.body}");

      return decodedResponse;
    } catch (e) {
      print('Error during logout call (Hardcoded Cookie): $e');
      return {'status': 'FAILED', 'reason': 'Network error'};
    }
  }

  Future<void> logoutAction(WidgetRef ref) async { // Modified to use hardcoded cookie logout
    final otpAuthService = OtpAuthService(); // Instance of OtpAuthService
    final Map<String, dynamic> logoutResponse = await otpAuthService.logout(); // Calls the logout with hardcoded cookie

    print(">>> Full logoutResponse (Hardcoded Cookie): $logoutResponse");

    // ** CHANGED: Check for isLoggedIn: false in the JSON body **
    if (logoutResponse['isLoggedIn'] == false) {
      print('Logout Successful! (Based on isLoggedIn: false response)');
      ref.read(isLoggedInProvider.notifier).state = false; // Update isLoggedInProvider to false

      // Optionally clear global variables related to user session if needed:
      globalUserName = null;
      globalFavListings = null;
      globalCookie = null; // Clear even the globalCookie for consistency
      globalCsrfToken = null;
      globalSessionId = null;
    } else {
      print(
          'Logout Failed (Hardcoded Cookie). Response did NOT have isLoggedIn: false. Response: $logoutResponse');
    }
  }
  Future<Map<String, dynamic>> validateOtp(
      {required String mobileNumber, required String otp}) async {
    final Uri uri = Uri.parse('$baseUrl/login/otpValidate');

    int otpAsInt;
    try {
      otpAsInt = int.parse(otp);
    } catch (e) {
      print(">>> ERROR parsing OTP to integer: $e");
      otpAsInt = 0;
    }

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "countryCode": 91,
          "mobileNumber": int.parse(mobileNumber),
          "otp": otpAsInt,
        }),
      );

      final decodedResponse = json.decode(response.body);
      final cookie = response.headers['set-cookie'];

      // ** Enhanced Debugging for validateOtp **
      print(">>> validateOtp API Response Status Code: ${response.statusCode}");
      print(">>> validateOtp API Response Body: ${response.body}");
      print(
          ">>> validateOtp API Set-Cookie Header: $cookie"); // Check the set-cookie header

      return {
        'body': decodedResponse,
        'cookie': cookie,
      };
    } catch (e) {
      print('Error validating OTP: $e');
      return {'status': 'FAILED', 'reason': 'Network error'};
    }
  }

  Future<Map<String, dynamic>> isLoggedIn() async {
  final Uri uri = Uri.parse('$baseUrl/isLoggedIn');
  // Hard-coded cookie for testing
  const cookie =
      "session=s%3A67a78ff9138e36a3f776780c.pduCbRJwYzKophKGclFKdWjJbWBVqrmobWnx%2FCYaE3o";

  try {
    final response = await http.get(
      uri,
      headers: {
        'Cookie': cookie,
      },
    );

    final decodedResponse = json.decode(response.body);

    print(">>> isLoggedIn API Response Status Code: ${response.statusCode}");
    print(">>> isLoggedIn API Response Body: ${response.body}");
    print(">>> isLoggedIn API CSRF Token (from response): ${decodedResponse['csrfToken']}");

    return decodedResponse;
  } catch (e) {
    print('Error during isLoggedIn call: $e');
    return {'isLoggedIn': false};
  }
}

  Future<Map<String, dynamic>> updateUserName(
      {required String countryCode, required String userName}) async {
    final Uri uri = Uri.parse('$baseUrl/update');

    print(">>> UsernameNotifier.updateUsername API Call Started!");
    print(">>> API Endpoint: $uri");
    print(">>> Updating Username to: $userName");

    final headers = {
      'Content-Type': 'application/json',
      'X-CSRFToken': globalCsrfToken ?? '',
      'Cookie': globalCookie ?? '',
    };
    print(">>> updateUserName API Headers: $headers");

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
        globalUserName = userName; // Still updating globalUserName for now
        print(">>> Username updated successfully via API and provider.");
        return decodedResponse;
      } else {
        print(
            ">>> Username update FAILED via API. Reason: ${decodedResponse['reason']}");
        return decodedResponse;
      }
    } catch (e) {
      print('Error updating username (in provider): $e');
      return {'status': 'FAILED', 'reason': 'Network error'};
    }
  }
}

Future<void> validateOtpAction(
    {required String mobileNumber, required String otp, required WidgetRef ref}) async {
  final otpAuthService = OtpAuthService();
  final Map<String, dynamic> otpResponse =
      await otpAuthService.validateOtp(mobileNumber: mobileNumber, otp: otp);

  print(">>> Full otpResponse['body']: ${otpResponse['body']}");

  if (otpResponse['body']['status'] == 'SUCCESS') {
    print('OTP Validation Successful! Getting user details...');
    globalCookie = otpResponse['cookie'];
    ref.read(isLoggedInProvider.notifier).state = true;
    final Map<String, dynamic> isLoggedInResponse =
        await otpAuthService.isLoggedIn();

    if (isLoggedInResponse['isLoggedIn'] == true) {
      print('User is logged in (isLoggedIn API success)');

      Map<String, dynamic>? userData =
          isLoggedInResponse['user'] as Map<String, dynamic>?;
      List<dynamic>? rawFavListings =
          userData?['favListings'] as List<dynamic>?;
      List<String>? parsedFavListings = rawFavListings
          ?.cast<String>()
          .where((element) => element.isNotEmpty)
          .toList();
      String? userName = userData?['userName'] as String?;
      String? csrfToken = isLoggedInResponse['csrfToken'] as String?;
      String? sessionId = isLoggedInResponse['sessionId'] as String?;

      globalUserName = userName;
      globalFavListings = parsedFavListings;
      globalCsrfToken = csrfToken;
      globalSessionId = sessionId;

      print(
          ">>> CSRF Token after isLoggedIn response: $globalCsrfToken"); // Already added this before
      print(
          ">>> Global Cookie after isLoggedIn and setting globalCookie: $globalCookie"); // ADDED this line

      print(
          'User data, Cookie, CSRF Token, Session ID stored in global memory.');
      print('Username: $globalUserName');
      print('Favorite Listings: $globalFavListings');
      print('CSRF Token: $globalCsrfToken');
      print('Session ID: $globalSessionId');
    } else {
      print('isLoggedIn API call failed after OTP validation.');
      print('isLoggedIn Response: $isLoggedInResponse');
    }
  } else {
    print(
        'OTP Validation Failed. Status: ${otpResponse['body']['status']}, Reason: ${otpResponse['body']['reason']}');
  }
}
