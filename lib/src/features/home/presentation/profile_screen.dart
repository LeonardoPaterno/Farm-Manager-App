import 'package:flutter/material.dart';
import 'package:myapp/src/features/auth/application/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Provider.of<AuthService>(context, listen: false).signOut();
          },
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
