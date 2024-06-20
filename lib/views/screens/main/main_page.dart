import 'package:davr_mobile/views/screens/history/history.dart';
import 'package:flutter/material.dart';

import '../home/home.dart';
import '../payments/payment_screen.dart';
import '../transaction/transactions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final screens = [
    const HomeScreen(),
    const PaymentScreen(),
    const TransactionScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) => setState(() => _selectedIndex = value),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Bosh menyu',
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.payments_outlined),
              label: "To'lovlar",
              activeIcon: Icon(Icons.payments)),
          BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange),
              label: "O'tkazmalar",
              activeIcon: Icon(Icons.currency_exchange_outlined)),
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Tarix',
              activeIcon: Icon(Icons.history_outlined)),
        ],
      ),
    );
  }
}
