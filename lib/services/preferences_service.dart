// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// class PreferencesService {
//   static Future<void> saveProviderDetails(String name, String mobile, String aadhar, String service) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     final key = 'workers_$service';
//     List<String> existingData = prefs.getStringList(key) ?? [];

//     if (existingData.length >= 15) return; // Max 15 entries

//     Map<String, String> newWorker = {
//       'name': name,
//       'mobile': mobile,
//       'aadhar': aadhar,
//       'service': service,
//     };

//     existingData.add(jsonEncode(newWorker));
//     await prefs.setStringList(key, existingData);
//   }

//   static Future<List<Map<String, String>>> getProviderDetails(String service) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();

//     final key = 'workers_$service';
//     List<String> encodedList = prefs.getStringList(key) ?? [];

//     return encodedList.map((item) => Map<String, String>.from(jsonDecode(item))).toList();
//   }
// }

// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/provider_model.dart';

// class PreferencesService {
//   static Future<void> saveProvider(ProviderModel provider) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> existing = prefs.getStringList(provider.service) ?? [];
//     existing.add(jsonEncode(provider.toJson()));
//     if (existing.length > 15) existing = existing.sublist(existing.length - 15);
//     await prefs.setStringList(provider.service, existing);
//     await prefs.setString('logged_in_provider', jsonEncode(provider.toJson()));
//     await prefs.setString('user_role', 'provider');
//   }

//   static Future<List<ProviderModel>> getProvidersForService(String service) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> providerStrings = prefs.getStringList(service) ?? [];
//     return providerStrings.map((str) => ProviderModel.fromJson(jsonDecode(str))).toList();
//   }

//   static Future<void> updateProviderRating(String service, String name, double rating) async {
//     List<ProviderModel> providers = await getProvidersForService(service);
//     for (int i = 0; i < providers.length; i++) {
//       if (providers[i].name == name) {
//         providers[i] = ProviderModel(
//           name: providers[i].name,
//           mobile: providers[i].mobile,
//           aadhar: providers[i].aadhar,
//           service: providers[i].service,
//           rating: rating,
//         );
//       }
//     }
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> updated = providers.map((p) => jsonEncode(p.toJson())).toList();
//     await prefs.setStringList(service, updated);
//   }

//   static Future<ProviderModel?> getLoggedInProvider() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? jsonStr = prefs.getString('logged_in_provider');
//     if (jsonStr != null) {
//       return ProviderModel.fromJson(jsonDecode(jsonStr));
//     }
//     return null;
//   }

//   static Future<void> logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('user_role');
//     await prefs.remove('logged_in_provider');
//   }
// }
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/provider_model.dart';
import '../models/customer_model.dart';

class PreferencesService {
  // Role handling
  static Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  // Customer management
  static Future<void> saveCustomer(CustomerModel customer) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInCustomer', jsonEncode(customer.toJson()));
    await prefs.setString('customer_${customer.phone}', jsonEncode(customer.toJson()));
    await prefs.setString('loggedInPhone', customer.phone);
  }

  static Future<CustomerModel?> getLoggedInCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    final customerJson = prefs.getString('loggedInCustomer');
    if (customerJson != null) {
      return CustomerModel.fromJson(jsonDecode(customerJson));
    }
    return null;
  }

  static Future<CustomerModel?> getCustomerByPhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    final customerJson = prefs.getString('customer_$phone');
    if (customerJson != null) {
      return CustomerModel.fromJson(jsonDecode(customerJson));
    }
    return null;
  }

  // Provider management
  static Future<void> saveProvider(ProviderModel provider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInProvider', jsonEncode(provider.toJson()));
    await prefs.setString('provider_${provider.phone}', jsonEncode(provider.toJson()));
    await prefs.setString('loggedInPhone', provider.phone);

    List<String> list = prefs.getStringList(provider.service) ?? [];
    if (list.length >= 15) list.removeAt(0);
    list.add(jsonEncode(provider.toJson()));
    await prefs.setStringList(provider.service, list);
  }

  static Future<ProviderModel?> getLoggedInProvider() async {
    final prefs = await SharedPreferences.getInstance();
    final providerJson = prefs.getString('loggedInProvider');
    if (providerJson != null) {
      return ProviderModel.fromJson(jsonDecode(providerJson));
    }
    return null;
  }

  static Future<ProviderModel?> getProviderByPhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    final providerJson = prefs.getString('provider_$phone');
    if (providerJson != null) {
      return ProviderModel.fromJson(jsonDecode(providerJson));
    }
    return null;
  }

  static Future<ProviderModel?> getProviderByMobile(String mobile) async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith('provider_')) {
        final jsonString = prefs.getString(key);
        if (jsonString != null) {
          final provider = ProviderModel.fromJson(jsonDecode(jsonString));
          if (provider.phone == mobile) {
            return provider;
          }
        }
      }
    }
    return null;
  }

  static Future<List<ProviderModel>> getAllProviders(String service) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList(service) ?? [];
    return list.map((e) => ProviderModel.fromJson(jsonDecode(e))).toList();
  }

  // Rating
  static Future<void> saveRating(String service, String providerMobile, double rating) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'rating_${service}_$providerMobile';
    await prefs.setDouble(key, rating);
  }

  static Future<double> getRating(String service, String providerMobile) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'rating_${service}_$providerMobile';
    return prefs.getDouble(key) ?? 0.0;
  }

  // OTP Session
  static Future<void> saveOtpSessionId(String sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('otpSessionId', sessionId);
  }

  static Future<String?> getOtpSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('otpSessionId');
  }

  // General
  static Future<String?> getLoggedInPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('loggedInPhone');
  }

  static Future<void> clearRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('role');
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInCustomer');
    await prefs.remove('loggedInProvider');
    await prefs.remove('role');
    await prefs.remove('loggedInPhone');
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
