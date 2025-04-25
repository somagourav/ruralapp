import 'package:flutter/material.dart';
import '../models/provider_model.dart';
import '../services/preferences_service.dart';
import 'provider_detail_screen.dart';
import 'role_selection_screen.dart';
import 'customer_details_screen.dart';
import 'search_with_google.dart'; // Import the SearchWithGoogleScreen

class CustomerDashboard extends StatefulWidget {
  final String customerMobile;

  const CustomerDashboard({super.key, required this.customerMobile});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  late Future<Map<String, List<ProviderModel>>> _serviceProviders;

  @override
  void initState() {
    super.initState();
    _serviceProviders = _loadProviders();
  }

  Future<Map<String, List<ProviderModel>>> _loadProviders() async {
    final services = [
      'Plumber', 'Electrician', 'Barber', 'Carpenter', 'Mechanic', 'Painter',
      'Welding Workers', 'Tractors Rent', 'Home Tuitions', 'Tent House',
      'Event Decors', 'Home Organizers', 'Cobbler', 'Home for Sale',
      'Bore Wells', 'Tailor', 'Packers and Movers', 'Centring', 'House for Rent'
    ];

    Map<String, List<ProviderModel>> serviceMap = {};
    for (var service in services) {
      serviceMap[service] = await PreferencesService.getAllProviders(service);
    }
    return serviceMap;
  }

  void _logout() async {
    await PreferencesService.logout();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => RoleSelectionScreen()),
        (route) => false,
      );
    }
  }

  void _viewCustomerDetails() async {
    final customer = await PreferencesService.getCustomerByPhone(widget.customerMobile);
    if (customer != null && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CustomerDetailsScreen(customer: customer),
        ),
      );
    }
  }

  void _rateProvider(String service, String mobile) async {
    final rating = await showDialog<double>(context: context, builder: (_) {
      double selectedRating = 3.0;
      return AlertDialog(
        title: const Text('Rate Provider'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Slider(
                value: selectedRating,
                min: 1,
                max: 5,
                divisions: 4,
                label: selectedRating.toString(),
                onChanged: (value) => setState(() => selectedRating = value),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, selectedRating),
            child: const Text('Submit'),
          ),
        ],
      );
    });

    if (rating != null) {
      await PreferencesService.addRating(service, mobile, rating);
      setState(() {});
    }
  }

  Future<double> _getProviderRating(String service, String mobile) async {
    return await PreferencesService.getAverageRating(service, mobile);
  }

  void _navigateToSearchWithGoogle() {
    List<String> services = [
      'Plumber', 'Electrician', 'Barber', 'Carpenter', 'Mechanic', 'Painter',
      'Welding Workers', 'Tractors Rent', 'Home Tuitions', 'Tent House',
      'Event Decors', 'Home Organizers', 'Cobbler', 'Home for Sale',
      'Bore Wells', 'Tailor', 'Packers and Movers', 'Centring', 'House for Rent'
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchWithGoogleScreen(services: services),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Customer Dashboard'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: _logout,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: _viewCustomerDetails,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Map<String, List<ProviderModel>>>(
              future: _serviceProviders,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final serviceMap = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.all(12),
                  children: serviceMap.entries
                      .where((entry) => entry.value.isNotEmpty)
                      .map((entry) => Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ExpansionTile(
                              backgroundColor: Colors.white,
                              collapsedIconColor: Colors.teal,
                              iconColor: Colors.teal,
                              title: Text(
                                entry.key,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal,
                                ),
                              ),
                              children: entry.value.map((provider) {
                                return FutureBuilder<double>(
                                  future: _getProviderRating(
                                      provider.service, provider.phone),
                                  builder: (context, ratingSnapshot) {
                                    final rating = ratingSnapshot.data ?? 0.0;
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.teal,
                                          child: Text(
                                            provider.name[0].toUpperCase(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                        title: Text(
                                          provider.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          'Mobile: ${provider.phone}\nRating: ${rating.toStringAsFixed(1)}',
                                        ),
                                        isThreeLine: true,
                                        trailing: SizedBox(
                                          width: 96,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.rate_review,
                                                    color: Colors.orange),
                                                onPressed: () =>
                                                    _rateProvider(
                                                        provider.service,
                                                        provider.phone),
                                                tooltip: 'Rate',
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.info,
                                                    color: Colors.blue),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          ProviderDetailScreen(
                                                              provider:
                                                                  provider),
                                                    ),
                                                  );
                                                },
                                                tooltip: 'Info',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ),
          // Search by Location Button at Bottom
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _navigateToSearchWithGoogle,
              icon: const Icon(Icons.location_on, color: Colors.white),
              label: const Text(
                'Search by Location',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
