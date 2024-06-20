import 'package:flutter/material.dart';

import 'jonnatmalar_screen.dart';
import 'tushum_screen.dart';

class TransactionsViaCards extends StatelessWidget {
  const TransactionsViaCards({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Kirim-Chiqim"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Jonatmalar'),
              Tab(text: 'Tushumlar'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            JonatmalarScreen(),
            TushumScreens(),
            
          ],
        ),
      ),
    );
  }
}
