import 'package:davr_mobile/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../controllers/cards_controller.dart';
import '../../../controllers/transactions_controllers.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/custom_drawer.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final trsController = TransactionsController();
  final cardsController = CardsController();

  final cardTextController = TextEditingController();
  final amountTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  int fromCard = 0;
  bool isCardChosen = false;
  double cardBalance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("O'tkazmalar"),
      ),
      drawer: const CustomDrawer(),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Lottie.asset('assets/lotties/pay_and_transfer.json', height: 200),
            20.height,

            /// Card input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: cardTextController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.credit_card),
                  labelText: 'Qabul qiluvchining karta raqami',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Karta raqamini kiriting";
                  }
                  RegExp regExp = RegExp(r'^\d+$');
                  if (!regExp.hasMatch(value.trim())) {
                    return "Mavjud karta raqamini kiriting";
                  }
                  return null;
                },
              ),
            ),
            10.height,

            /// Amount input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: amountTextController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.attach_money),
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Iltimos, miqdorni kiriting";
                  }
                  return null;
                },
              ),
            ),
            10.height,

            /// Send button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate() && isCardChosen) {
                        if (double.parse(amountTextController.text) >
                            cardBalance) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Kartada mablag' yetarli emas"),
                              );
                            },
                          );
                          return;
                        }
                        await trsController
                            .sendMoney(
                                fromCard,
                                int.parse(cardTextController.text),
                                double.parse(amountTextController.text))
                            .then((value) {
                          cardsController
                              .getCards()
                              .then((value) => setState(() {}));
                        });
                      }
                    },
                    child: const Text('Yuborish')),
              ),
            ),
            10.height,
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text('Mening kartalarim'),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: cardsController.getCards(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('Kartalar topilmadi');
                  }
                  final cards = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cards!.length,
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            fromCard = card.cardNumber.toInt();
                            cardBalance = card.balance.toDouble();
                            isCardChosen = true;
                            setState(() {});
                          },
                          child: CardWidget(
                            karta: card,
                            isThisCardChosen: card.cardNumber == fromCard,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
