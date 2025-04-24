// import 'package:flutter/material.dart';
// import 'customer_login_screen.dart';
// import 'customer_register_screen.dart';
// import 'provider_login_screen.dart';
// import 'provider_register_screen.dart';
// import 'role_selection_screen.dart';

// class AuthenticationScreen extends StatelessWidget {
//   final String role;

//   const AuthenticationScreen({required this.role});

//   @override
//   Widget build(BuildContext context) {
//     bool isCustomer = role == 'customer';

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('$role Authentication'.toUpperCase()),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) =>  RoleSelectionScreen()),
//             );
//           },
//         ),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Are you an existing $role?',
//                 style: TextStyle(fontSize: 18),
//               ),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   if (isCustomer) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => CustomerLoginScreen(),
//                       ),
//                     );
//                   } else {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ProviderLoginScreen(),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Login'),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (isCustomer) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => CustomerRegisterScreen(),
//                       ),
//                     );
//                   } else {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => ProviderRegisterScreen(),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Register'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'customer_login_screen.dart';
import 'customer_register_screen.dart';
import 'provider_login_screen.dart';
import 'provider_register_screen.dart';
import 'role_selection_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  final String role;

  const AuthenticationScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final bool isCustomer = role.toLowerCase() == 'customer';
    final Color primaryColor = isCustomer ? Colors.teal.shade600 : Colors.deepOrange.shade400;
    final Color secondaryColor = isCustomer ? Colors.tealAccent : Colors.orangeAccent;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar replacement
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => RoleSelectionScreen()),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${role[0].toUpperCase()}${role.substring(1).toLowerCase()} Authentication',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    const Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Are you an existing $role?',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (isCustomer) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CustomerLoginScreen(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProviderLoginScreen(),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.login),
                      label: const Text("Login", style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primaryColor,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 8,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (isCustomer) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CustomerRegisterScreen(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProviderRegisterScreen(),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.app_registration),
                      label: const Text("Register", style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primaryColor,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 8,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
