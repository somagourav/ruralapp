import 'package:flutter/material.dart';
import 'package:ruralapp/models/provider_model.dart';
import 'package:ruralapp/services/preferences_service.dart';
import 'package:ruralapp/screens/provider_dashboard.dart';
import 'package:ruralapp/screens/otp_verification_screen.dart';
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Register as Provider',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(_nameController, 'Name', Icons.person),
                    const SizedBox(height: 10),
                    _buildTextField(
                        _aadhaarController, 'Aadhaar Number', Icons.credit_card),
                    const SizedBox(height: 10),
                    _buildTextField(_phoneController, 'Mobile Number',
                        Icons.phone, TextInputType.phone),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedService,
                      decoration: InputDecoration(
                        labelText: 'Select Service',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: _services.map((service) {
                        return DropdownMenuItem(
                          value: service,
                          child: Text(service),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedService = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _registerProvider,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Send OTP & Register',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      IconData icon, [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
