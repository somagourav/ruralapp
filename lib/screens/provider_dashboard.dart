
import 'package:flutter/material.dart';
import '../models/provider_model.dart';
import '../services/preferences_service.dart';
import 'role_selection_screen.dart';

class ProviderDashboard extends StatefulWidget {
  final ProviderModel provider;

  const ProviderDashboard({super.key, required this.provider});

  @override
  State<ProviderDashboard> createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
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

  Future<void> _logout() async {
    await PreferencesService.logout();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) =>  RoleSelectionScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text('Provider Dashboard'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.teal.shade400,
                    child: const Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                infoRow("👤 Name", provider.name),
                const SizedBox(height: 10),
                infoRow("📞 Mobile", provider.phone),
                const SizedBox(height: 10),
                infoRow("🆔 Aadhaar", provider.aadhaar),
                const SizedBox(height: 10),
                infoRow("🛠️ Service", provider.service),
                const SizedBox(height: 20),
                const Divider(thickness: 1.2),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 28),
                    const SizedBox(width: 10),
                    Text(
                      'Average Rating: ${_averageRating.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade900,
                      ),
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

  Widget infoRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
