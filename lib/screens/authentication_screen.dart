


import 'package:flutter/material.dart';
import 'customer_login_screen.dart';
import 'customer_register_screen.dart';
import 'provider_login_screen.dart';
import 'provider_register_screen.dart';
import 'role_selection_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  final String role;

  const AuthenticationScreen({required this.role});

  @override
  Widget build(BuildContext context) {
    bool isCustomer = role.toLowerCase() == 'customer';

    final Color primaryColor = isCustomer ? Colors.teal.shade700 : Colors.deepOrange.shade700;
    final Color backgroundColor = isCustomer ? Colors.teal.shade50 : Colors.orange.shade50;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          '$role Authentication'.toUpperCase(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => RoleSelectionScreen()),
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isCustomer ? Icons.person : Icons.handyman,
                    size: 60,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Are you an existing $role?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[800]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.login),
                    label: const Text('Login', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (isCustomer) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CustomerLoginScreen()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ProviderLoginScreen()),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.app_registration),
                    label: const Text('Register', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor.withOpacity(0.9),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      if (isCustomer) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CustomerRegisterScreen()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ProviderRegisterScreen()),
                        );
                      }
                    },
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


