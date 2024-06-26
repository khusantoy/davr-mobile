import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:davr_mobile/views/screens/auth/login_screen.dart';
import 'package:davr_mobile/views/screens/auth/register_screen.dart';
import 'package:davr_mobile/views/screens/home_screen.dart';
import 'package:davr_mobile/views/screens/identification_screen.dart';
import 'package:davr_mobile/views/screens/profile_screen.dart';
import 'package:davr_mobile/views/screens/settings_screen.dart';
import 'package:davr_mobile/views/screens/splash_screen.dart';
import 'package:davr_mobile/views/screens/success_screen.dart';
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
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          theme: theme,
          darkTheme: darkTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            "/": (context) => const SplashScreen(),
            "/login": (context) => const LoginScreen(),
            "/register": (context) => const RegisterScreen(),
            "/home": (context) => const HomeScreen(),
            "/profile": (context) => const ProfileScreen(),
            "/identification": (context) => const IdentificationScreen(),
            "/success": (context) => const SuccessScreen(),
            "/settings": (context) => const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
