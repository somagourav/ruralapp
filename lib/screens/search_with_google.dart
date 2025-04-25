// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;

// class SearchWithGoogleScreen extends StatefulWidget {
//   final List<String> services;

//   const SearchWithGoogleScreen({Key? key, required this.services}) : super(key: key);

//   @override
//   State<SearchWithGoogleScreen> createState() => _SearchWithGoogleScreenState();
// }

// class _SearchWithGoogleScreenState extends State<SearchWithGoogleScreen> {
//   bool isLoading = false;
//   List<dynamic> nearbyResults = [];
//   String? errorMessage;

//   final String apiKey = 'AIzaSyAxyz_gFi-rMNiXHbJ13YjoLwRC72Rkovk';
//   Future<void> _getNearbyProviders(String service) async {
//   setState(() {
//     isLoading = true;
//     nearbyResults = [];
//     errorMessage = null;
//   });

//   try {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     final lat = position.latitude;
//     final lng = position.longitude;

//     final url = Uri.parse(
//       'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
//       '?location=$lat,$lng'
//       '&radius=5000'
//       '&keyword=${Uri.encodeComponent(service)}'
//       '&key=$apiKey',
//     );

//     final response = await http.get(url);
//     final data = json.decode(response.body);

//     if (data['status'] == 'OK') {
//       List<dynamic> results = data['results'];

//       // Add distance to each result
//       for (var result in results) {
//         final loc = result['geometry']['location'];
//         final providerLat = loc['lat'];
//         final providerLng = loc['lng'];

//         double distanceInMeters = Geolocator.distanceBetween(
//           lat,
//           lng,
//           providerLat,
//           providerLng,
//         );

//         result['distance'] = distanceInMeters;
//       }

//       // Sort by distance
//       results.sort((a, b) => (a['distance'] as double).compareTo(b['distance'] as double));

//       setState(() {
//         nearbyResults = results;
//       });
//     } else {
//       setState(() {
//         errorMessage = data['error_message'] ?? 'No results found.';
//       });
//     }
//   } catch (e) {
//     setState(() {
//       errorMessage = 'Error: $e';
//     });
//   } finally {
//     setState(() {
//       isLoading = false;
//     });
//   }
// }

//   Widget _buildGridItem(String service) {
//     return GestureDetector(
//       onTap: () {
//         _getNearbyProviders(service);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.lightBlue.shade50,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.blueAccent),
//         ),
//         padding: const EdgeInsets.all(12),
//         margin: const EdgeInsets.all(6),
//         child: Center(
//           child: Text(
//             service,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildResultsSection() {
//     if (isLoading) {
//       return const Padding(
//         padding: EdgeInsets.symmetric(vertical: 16.0),
//         child: Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (errorMessage != null) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 16.0),
//         child: Center(
//           child: Text(
//             errorMessage!,
//             style: const TextStyle(color: Colors.red),
//           ),
//         ),
//       );
//     }

//     if (nearbyResults.isEmpty) return const SizedBox();

//     return ListView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: nearbyResults.length,
//       itemBuilder: (context, index) {
//         final place = nearbyResults[index];
//         return Card(
//           margin: const EdgeInsets.symmetric(vertical: 6),
//           child: ListTile(
//             title: Text(place['name']),
//             subtitle: Text(place['vicinity'] ?? 'No address'),
//             leading: const Icon(Icons.place),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Providers by Location'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Select a Service:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: widget.services.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 2.5,
//               ),
//               itemBuilder: (context, index) {
//                 return _buildGridItem(widget.services[index]);
//               },
//             ),
//             const SizedBox(height: 20),
//             _buildResultsSection(),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
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
            const Text('Select a Service:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: widget.services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) => _buildGridItem(widget.services[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
