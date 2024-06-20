import 'package:davr_mobile/generated/assets.dart';
import 'package:davr_mobile/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/transactions_controllers.dart';
import '../../../../models/transaction.dart';

class JonatmalarScreen extends StatefulWidget {
  const JonatmalarScreen({super.key});

  @override
  State<JonatmalarScreen> createState() => _JonatmalarScreenState();
}

class _JonatmalarScreenState extends State<JonatmalarScreen> {
  final transactionsController = TransactionsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Transaction>>(
        future: transactionsController.getJonatmalar(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Jo\'natmalarni yuklab bo\'lmadi'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Jo'natmalar topilmadi"));
          }
          final jonatmalar = snapshot.data!;
          return ListView.builder(
            itemCount: jonatmalar.length,
            itemBuilder: (context, index) {
              final jonatma = jonatmalar[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      DateFormat('dd-MM-yyyy').format(
                        DateTime.parse(jonatma.date),
                      ),
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.redAccent,width: 0.3),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                            blurRadius: 9,
                            offset: Offset(0, 4),
                          ),
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(Assets.imagesExpense, height: 40),
                            6.height,
                            Text("${jonatma.toCard}")
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "-${jonatma.amount}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.redAccent,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              DateFormat('HH:mm').format(
                                DateTime.parse(jonatma.date),
                              ),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            5.height,
                            Container(
                              height: 25,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "O'tkazma",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
