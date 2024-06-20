import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sozlamalar"),
      ),
      body: SwitchListTile(
        value: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
        onChanged: (value) {
          setState(() {
                  isDark = !isDark;

                  isDark
                      ? AdaptiveTheme.of(context).setDark()
                      : AdaptiveTheme.of(context).setLight();
                });
        },
        title: const Text("Tungi rejim"),
      ),
    );
  }
}
