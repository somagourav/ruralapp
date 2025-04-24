import 'package:flutter/material.dart';
import '../models/service.dart';
import '../models/service_provider.dart';

class ServiceProviderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Service service = ModalRoute.of(context)!.settings.arguments as Service;

    // Dummy data for now – replace this with fetched data later
    final List<ServiceProvider> providers = [
      ServiceProvider(name: 'Raju Kumar', phone: '9876543210', rating: 4.5, service: service.name),
      ServiceProvider(name: 'Shyam Verma', phone: '9123456789', rating: 4.0, service: service.name),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('${service.name} Providers')),
      body: ListView.builder(
        itemCount: providers.length,
        itemBuilder: (context, index) {
          final provider = providers[index];
          return ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text(provider.name),
            subtitle: Text('Rating: ${provider.rating} ⭐'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/providerDetail',
                arguments: provider,
              );
            },
          );
        },
      ),
    );
  }
}
