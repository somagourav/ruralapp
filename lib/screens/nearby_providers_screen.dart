
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class NearbyProvidersScreen extends StatelessWidget {
//   final List<dynamic> providers;

//   const NearbyProvidersScreen({Key? key, required this.providers}) : super(key: key);

//   Future<void> _openInMaps(double lat, double lng) async {
//     final googleMapsUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
//     if (await canLaunchUrl(googleMapsUrl)) {
//       await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not launch Google Maps';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Nearby Providers')),
//       body: ListView.builder(
//         itemCount: providers.length,
//         itemBuilder: (context, index) {
//           final place = providers[index];
//           final lat = place['geometry']['location']['lat'];
//           final lng = place['geometry']['location']['lng'];

//           return Card(
//             margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             child: ListTile(
//               leading: const Icon(Icons.place, color: Colors.redAccent),
//               title: Text(place['name']),
//               subtitle: Text(
//                 '${place['vicinity'] ?? 'No address'}\n'
//                 '${(place['distance'] / 1000).toStringAsFixed(2)} km away',
//               ),
//               onTap: () => _openInMaps(lat, lng),
//               trailing: const Icon(Icons.directions, color: Colors.blueAccent),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyProvidersScreen extends StatelessWidget {
  final List<dynamic> providers;

  const NearbyProvidersScreen({Key? key, required this.providers}) : super(key: key);

  Future<void> _openInMaps(double lat, double lng) async {
    final googleMapsUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Nearby Providers'),
        backgroundColor: Colors.blue.shade600,
      ),
      body: ListView.builder(
        itemCount: providers.length,
        itemBuilder: (context, index) {
          final place = providers[index];
          final lat = place['geometry']['location']['lat'];
          final lng = place['geometry']['location']['lng'];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 5,
            shadowColor: Colors.blueAccent.withOpacity(0.3),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.white,
            child: ListTile(
              leading: const Icon(Icons.place, color: Colors.redAccent, size: 30),
              title: Text(
                place['name'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                '${place['vicinity'] ?? 'No address'}\n'
                '${(place['distance'] / 1000).toStringAsFixed(2)} km away',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              onTap: () => _openInMaps(lat, lng),
              trailing: const Icon(
                Icons.directions,
                color: Colors.blueAccent,
                size: 30,
              ),
            ),
          );
        },
      ),
    );
  }
}
