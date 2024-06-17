import 'package:davr_mobile/views/screens/auth/login_screen.dart';
import 'package:davr_mobile/views/screens/auth/register_screen.dart';
import 'package:davr_mobile/views/screens/home_screen.dart';
import 'package:davr_mobile/views/screens/identification_screen.dart';
import 'package:davr_mobile/views/screens/profile_screen.dart';
import 'package:davr_mobile/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          "/": (context) => const SplashScreen(),
          "/login": (context) => const LoginScreen(),
          "/register": (context) => const RegisterScreen(),
          "/home": (context) => const HomeScreen(),
          "/profile": (context) => const ProfileScreen(),
          "/identification": (context) => const IdentificationScreen(),
        },
      ),
    );
  }
}
