// import 'package:flutter/material.dart';
// import 'package:ruralapp/screens/customer_dashboard.dart';
// import 'package:ruralapp/services/preferences_service.dart';

// class CustomerLoginScreen extends StatefulWidget {
//   @override
//   _CustomerLoginScreenState createState() => _CustomerLoginScreenState();
// }

// class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
//   final TextEditingController _phoneController = TextEditingController();

//   void _login() async {
//     final phone = _phoneController.text.trim();
//     if (phone.isEmpty || phone.length != 10) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Enter a valid 10-digit phone number')),
//       );
//       return;
//     }

//     final customer = await PreferencesService.getCustomerByPhone(phone);
//     if (customer != null) {
//       await PreferencesService.saveCustomer(customer);
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => CustomerDashboard(customerMobile: customer.phone),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Customer not found. Please register.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Customer Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _phoneController,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//               keyboardType: TextInputType.phone,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _login,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:ruralapp/screens/customer_dashboard.dart';
import 'package:ruralapp/services/preferences_service.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  _CustomerLoginScreenState createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void _login() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty || phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid 10-digit phone number')),
      );
      return;
    }

    final customer = await PreferencesService.getCustomerByPhone(phone);
    if (customer != null) {
      await PreferencesService.saveCustomer(customer);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CustomerDashboard(customerMobile: customer.phone),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Customer not found. Please register.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Customer Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter Phone Number',
                      hintStyle: const TextStyle(color: Colors.white70),
                      prefixIcon: const Icon(Icons.phone, color: Colors.white),
                      filled: true,
                      fillColor: Colors.white24,
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _login,
                    icon: const Icon(Icons.login),
                    label: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.teal,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
