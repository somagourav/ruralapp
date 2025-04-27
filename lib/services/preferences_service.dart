import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../models/customer_model.dart';
import '../models/provider_model.dart';

class PreferencesService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Store role in SharedPreferences
  static Future<void> setRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  // Logout clears role
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('role');
    await prefs.remove('loggedInCustomer');
    await prefs.remove('loggedInProvider');
  }

  // Save provider to Firestore
  static Future<void> saveProvider(ProviderModel provider) async {
    await _firestore
        .collection('providers')
        .doc(provider.phone)
        .set(provider.toJson());

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInProvider', provider.phone);
  }

  // Save customer to Firestore
  static Future<void> saveCustomer(CustomerModel customer) async {
    await _firestore
        .collection('customers')
        .doc(customer.phone)
        .set(customer.toJson());

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInCustomer', customer.phone);
  }

  // Get customer from Firestore
  static Future<CustomerModel?> getCustomerByPhone(String phone) async {
    final doc = await _firestore.collection('customers').doc(phone).get();
    if (doc.exists) {
      return CustomerModel.fromJson(doc.data()!);
    }
    return null;
  }

  // Get provider from Firestore
  static Future<ProviderModel?> getProviderByMobile(String mobile) async {
    final doc = await _firestore.collection('providers').doc(mobile).get();
    if (doc.exists) {
      return ProviderModel.fromJson(doc.data()!);
    }
    return null;
  }

  // Get all providers for a service
  static Future<List<ProviderModel>> getAllProviders(String service) async {
    final querySnapshot = await _firestore
        .collection('providers')
        .where('service', isEqualTo: service)
        .get();

    return querySnapshot.docs
        .map((doc) => ProviderModel.fromJson(doc.data()))
        .toList();
  }

  // Save rating
  static Future<void> saveRating(String service, String providerPhone, double rating) async {
    await _firestore
        .collection('providers')
        .doc(providerPhone)
        .collection('ratings')
        .doc(service)
        .set({'rating': rating});
  }

  // Get rating
  static Future<double> getRating(String service, String providerPhone) async {
    final doc = await _firestore
        .collection('providers')
        .doc(providerPhone)
        .collection('ratings')
        .doc(service)
        .get();

    if (doc.exists && doc.data()?['rating'] != null) {
      return (doc.data()?['rating'] as num).toDouble();
    }
    return 0.0;
  }

  // Logged in customer
  static Future<CustomerModel?> getLoggedInCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('loggedInCustomer');
    if (phone != null) {
      return getCustomerByPhone(phone);
    }
    return null;
  }

  // Logged in provider
  static Future<ProviderModel?> getLoggedInProvider() async {
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('loggedInProvider');
    if (phone != null) {
      return getProviderByMobile(phone);
    }
    return null;
  }





  // AVG RATING
  // Add a new rating (accumulate multiple ratings)
static Future<void> addRating(String service, String providerPhone, double rating) async {
  final ratingRef = _firestore.collection('ratings').doc('$service-$providerPhone');

  final doc = await ratingRef.get();

  if (doc.exists && doc.data() != null) {
    final existingRatings = List<double>.from(doc['ratings'] ?? []);
    existingRatings.add(rating);
    await ratingRef.set({'ratings': existingRatings});
  } else {
    await ratingRef.set({'ratings': [rating]});
  }
}

static Future<double> getAverageRating(String service, String providerPhone) async {
  try {
    final doc = await _firestore.collection('ratings').doc('$service-$providerPhone').get();

    if (doc.exists && doc.data() != null) {
      final ratings = List<num>.from(doc['ratings'] ?? []);
      
      if (ratings.isEmpty) {
        return 0.0;  // Return 0 if there are no ratings
      }

      // Calculate the sum of ratings and divide by the length to get the average
      final total = ratings.fold(0.0, (sum, item) => sum + item.toDouble());
      return total / ratings.length;  // Return the average rating
    }
    
    // If no document found or ratings field is not present, return 0.0
    return 0.0;
  } catch (e) {
    debugPrint("Error fetching average rating: $e");
    return 0.0;  // Return 0 in case of an error
  }
}

}
