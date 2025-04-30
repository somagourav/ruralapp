import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'nearby_providers_screen.dart';

class SearchWithGoogleScreen extends StatefulWidget {
  final List<String> services;

  const SearchWithGoogleScreen({Key? key, required this.services}) : super(key: key);

  @override
  State<SearchWithGoogleScreen> createState() => _SearchWithGoogleScreenState();
}

class _SearchWithGoogleScreenState extends State<SearchWithGoogleScreen> {
  final String apiKey = 'AIzaSyAxyz_gFi-rMNiXHbJ13YjoLwRC72Rkovk';

  Future<void> _getNearbyProviders(String service) async {
    final hasPermission = await _checkLocationPermission();
    if (!hasPermission) {
      _showError('Location permission is required to find nearby providers.');
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final lat = position.latitude;
      final lng = position.longitude;

      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=$lat,$lng'
        '&radius=5000'
        '&keyword=${Uri.encodeComponent(service)}'
        '&key=$apiKey',
      );

      final response = await http.get(url);
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        List<dynamic> results = data['results'];

        for (var result in results) {
          final loc = result['geometry']['location'];
          final providerLat = loc['lat'];
          final providerLng = loc['lng'];
          double distance = Geolocator.distanceBetween(lat, lng, providerLat, providerLng);
          result['distance'] = distance;
        }

        results.sort((a, b) => (a['distance'] as double).compareTo(b['distance'] as double));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NearbyProvidersScreen(providers: results),
          ),
        );
      } else {
        _showError(data['error_message'] ?? 'No results found.');
      }
    } catch (e) {
      _showError('Error: $e');
    }
  }

  Future<bool> _checkLocationPermission() async {
    PermissionStatus status = await Permission.location.status;

    if (status.isGranted) return true;

    if (status.isDenied) {
      status = await Permission.location.request();
      return status.isGranted;
    }

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    return false;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  IconData _getServiceIcon(String service) {
    switch (service.toLowerCase()) {
      case 'plumber':
        return Icons.plumbing;
      case 'electrician':
        return Icons.electrical_services;
      case 'barber':
        return Icons.cut;
      case 'carpenter':
        return Icons.handyman;
      case 'mechanic':
        return Icons.build;
      case 'painter':
        return Icons.format_paint;
      case 'welding workers':
        return Icons.construction;
      case 'tractors rent':
        return Icons.agriculture;
      case 'home tuitions':
        return Icons.menu_book;
      case 'tent house':
        return Icons.emoji_events;
      case 'event decors':
        return Icons.celebration;
      case 'home organizers':
        return Icons.house;
      case 'cobbler':
        return Icons.shopping_bag;
      case 'home for sale':
        return Icons.real_estate_agent;
      case 'bore wells':
        return Icons.water;
      case 'tailor':
        return Icons.checkroom;
      case 'packers and movers':
        return Icons.local_shipping;
      case 'centring':
        return Icons.architecture;
      case 'house for rent':
        return Icons.home_work;
      case 'pop working':
        return Icons.wallpaper;
      case 'home made product':
        return Icons.shopping_cart;
      case 'skill training':
        return Icons.school;
      default:
        return Icons.miscellaneous_services;
    }
  }

  Widget _buildGridItem(String service) {
    return GestureDetector(
      onTap: () => _getNearbyProviders(service),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade100.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(3, 3),
            )
          ],
          border: Border.all(color: Colors.blueAccent.shade100),
        ),
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_getServiceIcon(service), size: 42, color: Colors.blueAccent),
            const SizedBox(height: 10),
            Text(
              service,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final allServices = [
      ...widget.services,
      'POP working',
      'Home Made product',
      'Skill training',
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Search Providers by Location'),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select a Service: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: allServices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) =>
                    _buildGridItem(allServices[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
