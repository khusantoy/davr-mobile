import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/cards_controller.dart';

class UserBalance extends StatefulWidget {
  const UserBalance({super.key});

  @override
  State<UserBalance> createState() => _UserBalanceState();
}

class _UserBalanceState extends State<UserBalance> {
  final cardsController = CardsController();
  bool isBalanceHidden = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cardsController.getCards(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Text('Kartalar topilmadi');
        }
        double sumBalance = 0;
        for (var card in snapshot.data!) {
          sumBalance += card.balance.toDouble();
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                  ? Colors.black
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isBalanceHidden
                    ? "**************"
                    : NumberFormat.simpleCurrency().format(sumBalance),
                style: GoogleFonts.inter(fontSize: 16),
              ),
              IconButton(
                onPressed: () =>
                    setState(() => isBalanceHidden = !isBalanceHidden),
                icon: Icon(isBalanceHidden
                    ? Icons.hide_source
                    : Icons.circle_outlined),
              )
            ],
          ),
        );
      },
    );
  }
}
