import 'package:flutter/material.dart';
import '../models/provider_model.dart';
import '../services/preferences_service.dart';
import 'provider_detail_screen.dart';

class ServiceProviderListScreen extends StatelessWidget {
  final String service;

  const ServiceProviderListScreen({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$service Providers')),
      body: FutureBuilder<List<ProviderModel>>(
        future: PreferencesService.getAllProviders(service),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No providers available'));
          }

          final providers = snapshot.data!;
          return ListView.builder(
            itemCount: providers.length,
            itemBuilder: (context, index) {
              final provider = providers[index];
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text('Phone: ${provider.phone}'),
                subtitle: Text('Aadhaar: ${provider.aadhaar}'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProviderDetailScreen(provider: provider),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
