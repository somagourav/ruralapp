import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer_model.dart';
import '../models/provider_model.dart';

class ApiService {
  // Replace this with your actual backend URL
  static const String baseUrl = 'http://localhost:3000';

  // Customer management
  static Future<CustomerModel?> getCustomerByPhone(String phone) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/customers/$phone'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CustomerModel.fromJson(data);
      }
    } catch (e) {
      print('Error fetching customer by phone: $e');
    }
    return null;
  }

  static Future<void> saveCustomer(CustomerModel customer) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/customers'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(customer.toJson()),
      );
      if (response.statusCode == 201) {
        print('Customer saved successfully');
      } else {
        print('Failed to save customer');
      }
    } catch (e) {
      print('Error saving customer: $e');
    }
  }

  // Provider management
  static Future<List<ProviderModel>> getProvidersByService(String service) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/providers/service/$service'));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => ProviderModel.fromJson(e)).toList();
      }
    } catch (e) {
      print('Error fetching providers by service: $e');
    }
    return [];
  }

  static Future<void> saveProvider(ProviderModel provider) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/providers'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(provider.toJson()),
      );
      if (response.statusCode == 201) {
        print('Provider saved successfully');
      } else {
        print('Failed to save provider');
      }
    } catch (e) {
      print('Error saving provider: $e');
    }
  }

  // Rating management
  static Future<void> saveRating(String service, String providerPhone, double rating) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/ratings'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service': service,
          'providerPhone': providerPhone,
          'rating': rating,
        }),
      );
      if (response.statusCode == 200) {
        print('Rating saved successfully');
      } else {
        print('Failed to save rating');
      }
    } catch (e) {
      print('Error saving rating: $e');
    }
  }

  static Future<double> getRating(String service, String providerPhone) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/ratings/$service/$providerPhone'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['rating'] ?? 0.0;
      }
    } catch (e) {
      print('Error fetching rating: $e');
    }
    return 0.0;
  }

  // OTP Session management
  static Future<void> saveOtpSessionId(String sessionId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/otp/session'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'sessionId': sessionId}),
      );
      if (response.statusCode == 200) {
        print('OTP session saved successfully');
      } else {
        print('Failed to save OTP session');
      }
    } catch (e) {
      print('Error saving OTP session: $e');
    }
  }

  static Future<String?> getOtpSessionId() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/otp/session'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['sessionId'];
      }
    } catch (e) {
      print('Error fetching OTP session: $e');
    }
    return null;
  }
}
