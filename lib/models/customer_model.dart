// lib/models/customer_model.dart
class CustomerModel {
  final String name;
  final String phone;

  CustomerModel({required this.name, required this.phone});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
      };

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      name: json['name'],
      phone: json['phone'],
    );
  }

  // Fix for missing field used in other screen
  String get mobile => phone;
}
