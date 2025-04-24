import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  // Save provider details with mobile, aadhar, and service.
  static Future<void> saveProviderDetails(String mobile, String aadhar, String service) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('providerMobile', mobile);
    prefs.setString('providerAadhar', aadhar);
    prefs.setString('selectedService', service);
  }

  // Get all provider details.
  static Future<Map<String, String>> getProviderDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? mobile = prefs.getString('providerMobile');
    final String? aadhar = prefs.getString('providerAadhar');
    final String? service = prefs.getString('selectedService');

    return {
      'mobile': mobile ?? '',
      'aadhar': aadhar ?? '',
      'service': service ?? '',
    };
  }

  // Clear provider details.
  static Future<void> clearProviderDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('providerMobile');
    prefs.remove('providerAadhar');
    prefs.remove('selectedService');
  }
}
