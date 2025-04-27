import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ruralapp/screens/customer_dashboard.dart';
import 'package:ruralapp/screens/provider_dashboard.dart';
import 'package:ruralapp/screens/role_selection_screen.dart';
import 'package:ruralapp/services/preferences_service.dart';
import 'models/customer_model.dart';
import 'models/provider_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // 🔥 Initialize Firebase
  await _requestLocationPermission(); // 🌍 Request location permission at launch
  runApp(const MyApp());
}

Future<void> _requestLocationPermission() async {
  final status = await Permission.location.status;
  if (!status.isGranted) {
    await Permission.location.request();
  }
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
      _home =  RoleSelectionScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _home;
  }
}
