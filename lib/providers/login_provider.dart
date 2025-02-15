import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Phone Number Provider
final phoneNumberProvider = StateProvider<String>((ref) => "");

// Checkbox State Provider
final termsAcceptedProvider = StateProvider<bool>((ref) => false);

// Very Simplified Auth State class
class AuthState {
 final bool isLoading;
 final bool isOtpSent;

 AuthState({
  this.isLoading = false,
  this.isOtpSent = false,
 });

 AuthState copyWith({
  bool? isLoading,
  bool? isOtpSent,
 }) {
  return AuthState(
   isLoading: isLoading ?? this.isLoading,
   isOtpSent: isOtpSent ?? this.isOtpSent,
  );
 }
}


class AuthService {
 final String baseUrl = 'http://40.90.224.241:5000';

 Future<String> generateOtp({required String mobileNumber}) async {
  final Uri uri = Uri.parse('$baseUrl/login/otpCreate');

  try {
   final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
     "countryCode": 91,
     "mobileNumber": int.parse(mobileNumber),
    }),
   );

   final decodedResponse = json.decode(response.body);
   print(decodedResponse);
   return decodedResponse['status'] ?? 'FAILED';

  } catch (e) {
   print('Error generating OTP (in try-catch block): $e');
   return 'FAILED';
  }
 }
}


class AuthNotifier extends StateNotifier<AuthState> {
 final AuthService authService; // AuthService is now defined above
 final Ref ref; // Need Ref to read phoneNumberProvider

 AuthNotifier({required this.authService, required this.ref}) : super(AuthState());

 Future<void> generateOtp() async { 
  state = state.copyWith(isLoading: true, isOtpSent: false);

  final mobileNumberString = ref.read(phoneNumberProvider); // Read mobileNumber from provider

  final responseStatus = await authService.generateOtp(mobileNumber: mobileNumberString);

  state = state.copyWith(
   isLoading: false,
   isOtpSent: responseStatus == 'SUCCESS',
  );

  if (responseStatus != 'SUCCESS') {
   print('OTP Generation Failed. Status: $responseStatus');
  }
 }
}

// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
 (ref) => AuthNotifier(authService: AuthService(), ref: ref), // AuthService is now defined above
);