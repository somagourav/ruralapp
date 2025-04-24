// import 'package:flutter/material.dart';
// import '../models/customer_model.dart';

// class CustomerDetailsScreen extends StatelessWidget {
//   final CustomerModel customer;

//   const CustomerDetailsScreen({Key? key, required this.customer}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Customer Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Name: ${customer.name}', style: const TextStyle(fontSize: 20)),
//             const SizedBox(height: 12),
//             Text('Mobile: ${customer.phone}', style: const TextStyle(fontSize: 20)),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Back to Dashboard'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../models/customer_model.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final CustomerModel customer;

  const CustomerDetailsScreen({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text('Customer Details'),
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.teal.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.white, size: 28),
                      const SizedBox(width: 10),
                      Text(
                        customer.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.white, size: 26),
                      const SizedBox(width: 10),
                      Text(
                        customer.phone,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Dashboard'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.teal,
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
