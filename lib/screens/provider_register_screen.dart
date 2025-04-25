
import 'package:flutter/material.dart';
import '../models/provider_model.dart';
import '../services/preferences_service.dart';
import 'otp_verification_screen.dart';
import 'role_selection_screen.dart';
import 'customer_details_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProviderRegisterScreen extends StatefulWidget {
  @override
  _ProviderRegisterScreenState createState() => _ProviderRegisterScreenState();
}

class _ProviderRegisterScreenState extends State<ProviderRegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedService = 'Plumber';

  final List<String> _services = [
    'Plumber', 'Electrician', 'Barber', 'Carpenter', 'Mechanic', 'Painter',
    'Welding Workers', 'Tractors Rent', 'Home Tuitions', 'Tent House',
    'Event Decors', 'Home Organizers', 'Cobbler', 'Home for Sale',
    'Bore Wells', 'Tailor', 'Packers and Movers', 'Centring', 'House for Rent',
  ];

  Future<void> _registerProvider() async {
    final name = _nameController.text.trim();
    final aadhaar = _aadhaarController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || aadhaar.isEmpty || phone.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fill all fields correctly')),
      );
      return;
    }

    final apiKey = 'd1824f80-12c0-11f0-8b17-0200cd936042';
    final url = Uri.parse(
        'https://2factor.in/API/V1/$apiKey/SMS/+91$phone/AUTOGEN/ProviderRegister');

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);
      if (data['Status'] == 'Success') {
        final sessionId = data['Details'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OTPVerificationScreen(),
            settings: RouteSettings(arguments: {
              'sessionId': sessionId,
              'role': 'provider',
              'phone': phone,
              'providerDetails': {
                'name': name,
                'aadhaar': aadhaar,
                'phone': phone,
                'service': _selectedService,
              }
            }),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send OTP')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error sending OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9D976), Color(0xFFF39F86)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Register as Service Provider',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Provider Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _aadhaarController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Aadhaar Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedService,
                onChanged: (value) {
                  setState(() {
                    _selectedService = value!;
                  });
                },
                items: _services.map((service) {
                  return DropdownMenuItem<String>(
                    value: service,
                    child: Text(service),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Select Service',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerProvider,
                child: const Text('Register'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) =>  RoleSelectionScreen()),
                  );
                },
                child: const Text('Back to Role Selection'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
