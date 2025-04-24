import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ruralapp/models/provider_model.dart';
import 'package:ruralapp/models/customer_model.dart';
import 'package:ruralapp/services/preferences_service.dart';
import 'package:ruralapp/screens/customer_dashboard.dart';
import 'package:ruralapp/screens/provider_dashboard.dart';

class OTPVerificationScreen extends StatefulWidget {
  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool isVerifying = false;
  String? sessionId;
  String? phone;
  String? role;
  Map? providerDetails;
  Map? customerDetails;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    sessionId = args['sessionId'];
    role = args['role'];
    phone = args['phone'];
    providerDetails = args['providerDetails'];
    customerDetails = args['customerDetails'];
    super.didChangeDependencies();
  }

  Future<void> verifyOTP() async {
    final otp = _otpController.text.trim();
    if (otp.isEmpty || otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enter a valid 6-digit OTP')),
      );
      return;
    }

    setState(() {
      isVerifying = true;
    });

    final apiKey = 'd1824f80-12c0-11f0-8b17-0200cd936042';
    final url = Uri.parse('https://2factor.in/API/V1/$apiKey/SMS/VERIFY/$sessionId/$otp');

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (data['Status'] == 'Success') {
        if (role == 'customer' && customerDetails != null) {
          final customer = CustomerModel(
            name: customerDetails!['name'],
            phone: customerDetails!['phone'],
          );
          await PreferencesService.saveCustomer(customer);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => CustomerDashboard(customerMobile: customer.phone),
            ),
          );
        } else if (role == 'provider' && providerDetails != null) {
          final provider = ProviderModel(
            name: providerDetails!['name'],
            phone: providerDetails!['phone'],
            aadhaar: providerDetails!['aadhaar'],
            service: providerDetails!['service'],
            rating: 0.0,
          );
          await PreferencesService.saveProvider(provider);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ProviderDashboard(provider: provider),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Missing user data')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP verification failed: ${data['Details']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error verifying OTP')),
      );
    } finally {
      setState(() {
        isVerifying = false;
      });
    }
  }

  Future<void> resendOTP() async {
    final apiKey = 'd1824f80-12c0-11f0-8b17-0200cd936042';
    final url = Uri.parse(
      'https://2factor.in/API/V1/$apiKey/SMS/+91$phone/AUTOGEN/${role == 'customer' ? "CustomerLogin" : "ProviderLogin"}',
    );

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);
      if (data['Status'] == 'Success') {
        setState(() {
          sessionId = data['Details'];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP resent successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to resend OTP')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error resending OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: Text('OTP Verification'),
        backgroundColor: Colors.teal,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              'Enter the OTP sent to +91-$phone',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.teal.shade900),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _otpController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '6-digit OTP',
                filled: true,
                fillColor: Colors.white,
                counterText: '',
                prefixIcon: Icon(Icons.lock, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            isVerifying
                ? CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: verifyOTP,
                      icon: Icon(Icons.verified_user),
                      label: Text('Verify OTP'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        textStyle: TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: resendOTP,
              child: Text(
                'Didn\'t get the OTP? Resend',
                style: TextStyle(color: Colors.teal.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
