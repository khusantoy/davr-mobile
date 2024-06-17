import 'package:flutter/material.dart';

import '../home/home.dart';
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
    const Center(child: Text('Payment')),
    const TransactionScreen(),
    const Center(child: Text('History')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[_selectedIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(splashColor: Colors.transparent),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) => setState(() => _selectedIndex = value),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
                activeIcon: Icon(Icons.home)),
            BottomNavigationBarItem(
                icon: Icon(Icons.payments_outlined),
                label: 'Payments',
                activeIcon: Icon(Icons.payments)),
            BottomNavigationBarItem(
                icon: Icon(Icons.currency_exchange),
                label: 'Transactions',
                activeIcon: Icon(Icons.currency_exchange_outlined)),
            BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
                activeIcon: Icon(Icons.history_outlined)),
          ],
        ),
      ),
    );
  }
}
