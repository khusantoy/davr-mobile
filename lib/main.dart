import 'package:davr_mobile/views/screens/auth/login_screen.dart';
import 'package:davr_mobile/views/screens/auth/register_screen.dart';
import 'package:davr_mobile/views/screens/onboarding/identification_screen.dart';
import 'package:davr_mobile/views/screens/profile_screen.dart';
import 'package:davr_mobile/views/screens/onboarding/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'views/screens/home/home.dart';
import 'views/screens/main/main_page.dart';

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
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          "/": (context) => const SplashScreen(),
          '/main': (context) => MainScreen(),
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
