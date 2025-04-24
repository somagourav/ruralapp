import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Rural Services'),
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
          ),
          ListTile(
            title: Text('Role Selection'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/roleSelection');
            },
          ),
          ListTile(
            title: Text('Customer Dashboard'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/customerDashboard');
            },
          ),
          ListTile(
            title: Text('Provider Details'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/providerDetail');
            },
          ),
          ListTile(
            title: Text('Provider Registration'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/providerRegister');
            },
          ),
          ListTile(
            title: Text('Service Provider List'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/serviceProviderList');
            },
          ),
          ListTile(
            title: Text('Provider Login'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/providerLogin');
            },
          ),
        ],
      ),
    );
  }
}
