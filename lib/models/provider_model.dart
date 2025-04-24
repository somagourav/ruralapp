class ProviderModel {
  final String name;
  final String phone;
  final String aadhaar;
  final String service;
  final double rating;

  ProviderModel({
    required this.name,
    required this.phone,
    required this.aadhaar,
    required this.service,
    required this.rating,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'aadhaar': aadhaar,
        'service': service,
        'rating': rating,
      };

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      name: json['name'],
      phone: json['phone'],
      aadhaar: json['aadhaar'],
      service: json['service'],
      rating: (json['rating'] ?? 0).toDouble(),
    );
  }

    String get mobile => phone;
  String get aadhaarNumber => aadhaar;
}

