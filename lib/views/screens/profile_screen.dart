import 'package:davr_mobile/main.dart';
import 'package:davr_mobile/services/auth_http_services.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const MyApp();
                  },
                ),
              );
              return AuthHttpServices.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
