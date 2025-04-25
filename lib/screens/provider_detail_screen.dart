


import 'package:flutter/material.dart';
import '../models/provider_model.dart';
import '../services/preferences_service.dart';

class ProviderDetailScreen extends StatefulWidget {
  final ProviderModel provider;

  const ProviderDetailScreen({Key? key, required this.provider}) : super(key: key);

  @override
  State<ProviderDetailScreen> createState() => _ProviderDetailScreenState();
}

class _ProviderDetailScreenState extends State<ProviderDetailScreen> {
  double _averageRating = 0.0;

  @override
  void initState() {
    super.initState();
    _loadAverageRating();
  }

  void _loadAverageRating() async {
    double avg = await PreferencesService.getAverageRating(
      widget.provider.service,
      widget.provider.phone,
    );
    if (mounted) {
      setState(() {
        _averageRating = avg;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: const Text('Provider Details'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.teal.shade400,
                  child: const Icon(Icons.person, color: Colors.white, size: 50),
                ),
                const SizedBox(height: 20),
                detailRow(Icons.phone, 'Phone', widget.provider.phone),
                const SizedBox(height: 12),
                detailRow(Icons.credit_card, 'Aadhaar', widget.provider.aadhaar),
                const SizedBox(height: 12),
                detailRow(Icons.home_repair_service, 'Service', widget.provider.service),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange),
                    const SizedBox(width: 8),
                    Text(
                      'Rating: ${_averageRating.toStringAsFixed(1)} ⭐',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget detailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.teal.shade700),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
