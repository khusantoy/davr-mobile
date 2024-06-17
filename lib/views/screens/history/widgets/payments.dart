import 'package:flutter/material.dart';

class Payments extends StatelessWidget {
  const Payments({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("To'lovlar"),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Kartalar'),
              Tab(text: 'To\'lovlar'),
              Tab(text: 'Malumotlar'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Column(),
            Column(),
            Column(),
          ],
        ),
      ),
    );
  }
}