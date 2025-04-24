import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/provider_model.dart';
import '../services/preferences_service.dart';
import 'provider_dashboard.dart';

class ProviderLoginScreen extends StatefulWidget {
  const ProviderLoginScreen({super.key});

  @override
  State<ProviderLoginScreen> createState() => _ProviderLoginScreenState();
}

class _ProviderLoginScreenState extends State<ProviderLoginScreen> {
  final TextEditingController _mobileController = TextEditingController();

  void _loginProvider() async {
    final mobile = _mobileController.text.trim();

    if (mobile.isEmpty || mobile.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid 10-digit mobile number')),
      );
      return;
    }

    final provider = await PreferencesService.getProviderByMobile(mobile);

    if (provider == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mobile number not registered')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userRole', 'provider');
    await prefs.setString('loggedInMobile', mobile);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProviderDashboard(provider: provider),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8EC5FC), Color(0xFFE0C3FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Provider Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _loginProvider,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Login', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


