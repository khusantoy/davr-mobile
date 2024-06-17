// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/transactions_controllers.dart';
import '../../../../models/transaction.dart';

class JonatmalarScreen extends StatefulWidget {
  @override
  _JonatmalarScreenState createState() => _JonatmalarScreenState();
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
            print('Snapshot Error: ${snapshot.error}');
            return const Center(child: Text('Could not load Jonatmalar'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print('No data found or empty list');
            return const Center(child: Text('No Jonatmalar found'));
          }
          final jonatmalar = snapshot.data!;
          return ListView.builder(
            itemCount: jonatmalar.length,
            itemBuilder: (context, index) {
              final jonatma = jonatmalar[index];
              return Column(
                children: [
                  // Container(
                  //   height: 1,
                  //   width: double.infinity,
                  //   color: Colors.blue,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(
                            DateTime.parse(jonatma.date),
                          ),
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          "-${jonatma.amount} so'm",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 80,
                            width: 120,
                            color: Colors.red,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "-${jonatma.amount} so'm",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                ),
                                textAlign: TextAlign.end,
                              ),
                              SizedBox(height: 5),
                              Text(
                                DateFormat('HH:mm').format(
                                  DateTime.parse(jonatma.date),
                                ),
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 25,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                child: Center(
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
