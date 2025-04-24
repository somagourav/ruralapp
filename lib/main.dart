// import 'package:flutter/material.dart';
// // Firebase core and configuration (keep only if you're using Firebase features other than OTP)
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// // Screens
// import 'screens/role_selection_screen.dart';
// import 'screens/customer_login_screen.dart';
// import 'screens/otp_verification_screen.dart';
// import 'screens/customer_dashboard.dart';
// import 'screens/provider_login_screen.dart';
// import 'screens/provider_register_screen.dart';
// import 'screens/service_provider_list.dart';
// import 'screens/provider_detail_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   } catch (e) {
//     // Handle already initialized or any issue gracefully
//     debugPrint('Firebase already initialized or failed to initialize: $e');
//   }

//   runApp(RuralServicesApp());
// }

// class RuralServicesApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Rural Services App',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//         scaffoldBackgroundColor: Colors.grey[100],
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => RoleSelectionScreen(),
//         '/customerLogin': (context) => CustomerLoginScreen(),
//         '/otpVerification': (context) => OTPVerificationScreen(),
//         '/customerDashboard': (context) => CustomerDashboard(),
//         '/providerLogin': (context) => ProviderLoginScreen(),
//         '/providerRegister': (context) => ProviderRegisterScreen(),
//         '/serviceProviderList': (context) => ServiceProviderListScreen(),
//         '/providerDetail': (context) => ProviderDetailScreen(),
//       },
//     );
//   }
// }Oka sari run ayydhi





// import 'package:flutter/material.dart';
// // Firebase core and configuration
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// // Screens
// import 'screens/otp_verification_screen.dart';
// import 'screens/role_selection_screen.dart';
// import 'screens/customer_login_screen.dart';
// import 'screens/customer_dashboard.dart';
// import 'screens/provider_login_screen.dart';
// import 'screens/provider_register_screen.dart';
// import 'screens/service_provider_list.dart';
// import 'screens/provider_detail_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   } catch (e) {
//     debugPrint('Firebase already initialized: $e');
//   }

//   runApp(RuralServicesApp());
// }

// class RuralServicesApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Rural Services App',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//         scaffoldBackgroundColor: Colors.grey[100],
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => RoleSelectionScreen(),
//         '/customerLogin': (context) => CustomerLoginScreen(),
//         '/otpVerification': (context) => OTPVerificationScreen(),
//         '/customerDashboard': (context) => CustomerDashboard(),
//         '/providerLogin': (context) => ProviderLoginScreen(),
//         '/providerRegister': (context) => ProviderRegisterScreen(),
//         '/serviceProviderList': (context) => ServiceProviderListScreen(),
//         '/providerDetail': (context) => ProviderDetailScreen(),
//       },
//     );
//   }
// }


// dummy code works good

// import 'package:flutter/material.dart';
// import 'screens/customer_dashboard.dart';
// import 'screens/provider_register_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Rural Services App (Test Mode)',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.green),
//       home: TestModeHome(), // You can change this to any screen for testing
//     );
//   }
// }

// class TestModeHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Test Mode Home"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               child: Text("Go to Customer Dashboard"),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => CustomerDashboard(),
//                 ));
//               },
//             ),
//             ElevatedButton(
//               child: Text("Go to Provider Register"),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(
//                   builder: (context) => ProviderRegisterScreen(),
//                 ));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// dummy code

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'models/provider_model.dart';
// import 'screens/customer_dashboard.dart';
// import 'screens/provider_dashboard.dart';
// import 'screens/provider_register_screen.dart';
// import 'screens/role_selection_screen.dart';
// import 'services/preferences_service.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Widget _home = RoleSelectionScreen();

//   @override
//   void initState() {
//     super.initState();
//     _loadInitialScreen();
//   }

//   Future<void> _loadInitialScreen() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? role = prefs.getString('user_role');

//     if (role == 'customer') {
//       setState(() {
//         _home = CustomerDashboard();
//       });
//     } else if (role == 'provider') {
//       ProviderModel? provider = await PreferencesService.getLoggedInProvider();
//       if (provider != null) {
//         setState(() {
//           _home = ProviderDashboard(provider: provider);
//         });
//       } else {
//         setState(() {
//           _home = RoleSelectionScreen();
//         });
//       }
//     } else {
//       setState(() {
//         _home = RoleSelectionScreen();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Rural Services',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.teal),
//       home: _home,
//       routes: {
//         '/roleSelection': (context) => RoleSelectionScreen(),
//         '/customerDashboard': (context) => CustomerDashboard(),
//         '/providerRegister': (context) => ProviderRegisterScreen(),
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:ruralapp/screens/customer_dashboard.dart';
import 'package:ruralapp/screens/provider_dashboard.dart';
import 'package:ruralapp/screens/role_selection_screen.dart';
import 'package:ruralapp/services/preferences_service.dart';
import 'models/customer_model.dart';
import 'models/provider_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rural Services App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const SplashHandler(),
    );
  }
}

class SplashHandler extends StatefulWidget {
  const SplashHandler({super.key});

  @override
  State<SplashHandler> createState() => _SplashHandlerState();
}

class _SplashHandlerState extends State<SplashHandler> {
  Widget _home = const Scaffold(body: Center(child: CircularProgressIndicator()));

  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    final role = await PreferencesService.getRole();

    if (role == 'Customer') {
      final customer = await PreferencesService.getLoggedInCustomer();
      if (customer != null) {
        setState(() {
          _home = CustomerDashboard(customerMobile: customer.phone);
        });
        return;
      }
    } else if (role == 'Service Provider') {
      final provider = await PreferencesService.getLoggedInProvider();
      if (provider != null) {
        setState(() {
          _home = ProviderDashboard(provider: provider);
        });
        return;
      }
    }

    setState(() {
      _home = RoleSelectionScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _home;
  }
}
