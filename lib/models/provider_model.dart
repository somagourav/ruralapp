class ProviderModel {
  final String phone;
  final String name;
  final String service;
  final String aadhaar;
  final double rating; // Add this field

  ProviderModel({
    required this.phone,
    required this.name,
    required this.service,
    required this.aadhaar,
    this.rating = 0.0, // Default to 0.0 if no rating is provided
  });

  // fromJson and toJson for serialization and deserialization
  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      phone: json['phone'],
      name: json['name'],
      service: json['service'],
      aadhaar: json['aadhaar'],
      rating: json['rating'] ?? 0.0, // Add rating deserialization
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'name': name,
      'service': service,
      'aadhaar': aadhaar,
      'rating': rating, // Add rating serialization
    };
  }
}
