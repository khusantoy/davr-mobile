import 'package:davr_mobile/views/screens/auth/login_screen.dart';
import 'package:davr_mobile/views/screens/home_screen.dart';
import 'package:davr_mobile/views/screens/identification_screen.dart';
import 'package:davr_mobile/views/screens/profile_screen.dart';
import 'package:davr_mobile/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        "/": (context) => const SplashScreen(),
        "/login": (context) => const LoginScreen(),
        "/home": (context) => const HomeScreen(),
        "/profile": (context) => const ProfileScreen(),
        "/identification": (context) => const IdentificationScreen(),
      },
    );
  }
}
