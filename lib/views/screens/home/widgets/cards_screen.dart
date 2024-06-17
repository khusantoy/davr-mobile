import 'package:davr_mobile/views/screens/home/widgets/add_card_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/cards_controller.dart';
import '../../../widgets/card_widget.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final cardsController = CardsController();

  void addCard() async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return const AddCardDialog();
      },
    );
    if (data != null) {
      try {
        cardsController.addCard(
          balance: data['balance'],
          bankName: data['bankName'],
          cardName: data['cardName'],
          cardNumber: data['cardNumber'],
          expiryDate: data['expiryDate'],
          type: data['type'],
        );
        setState(() {});
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
      ),
      body: FutureBuilder(
        future: cardsController.getCards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Text("no Cards");
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final card = snapshot.data![index];
              return CardWidget(karta: card);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addCard();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
