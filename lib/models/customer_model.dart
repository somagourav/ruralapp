import 'dart:convert';

class CustomerModel {
  final String phone;
  final String name;

  CustomerModel({required this.phone, required this.name});

  // fromJson and toJson for serialization and deserialization
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      phone: json['phone'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'name': name,
    };
  }
}

