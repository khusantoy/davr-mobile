import 'package:davr_mobile/views/screens/history/widgets/payments_to_services.dart';
import 'package:davr_mobile/views/screens/history/widgets/transactions_via_cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_drawer.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (ctx) => const TransactionsViaCards(),
                    ),
                  );
                },
                tileColor: Colors.grey.shade200,
                leading: const Icon(
                  Icons.transform_outlined,
                  size: 25,
                  color: Colors.black,
                ),
                title: const Text(
                  "Kirim-Chiqim",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 60,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (ctx) => const PaymentToServices(),
                    ),
                  );
                },
                tileColor: Colors.grey.shade200,
                title: Text("Xizmatga to'lovlar"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                  color: Colors.black,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
