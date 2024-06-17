import 'dart:math';

import 'package:davr_mobile/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCardDialog extends StatefulWidget {
  const AddCardDialog({super.key});

  @override
  State<AddCardDialog> createState() => _AddCardDialogState();
}

class _AddCardDialogState extends State<AddCardDialog> {
  // String? userId;

  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryMonthController = TextEditingController();
  final expiryYearController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // getUserId();
  }

  // getUserId() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   userId = sharedPreferences.getString("userId");
  //   setState(() {});
  // }

  final banks = [
    "Asaka Bank",
    "Ipoteka Bank",
    "Asia Alliance Bank",
    "Ziraat Bank Uzbekistan",
    "Aloqabank",
    "Garant Bank",
    "Agrobank",
    "Hamkorbank",
    "InfinBank",
    "Kapitalbank",
    "National Bank",
    "Orient Finans",
    "Turon Bank",
    "UzKDB Bank",
    "Uzpromstroybank",
  ];

  void submit() {
    if (formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        {
          "balance": Random().nextDouble() * 500000 + 50000,
          "bankName": banks[Random().nextInt(banks.length)],
          "cardName": cardNameController.text,
          "cardNumber": int.parse(cardNumberController.text),
          "expiryDate":
              "${expiryMonthController.text}-${expiryYearController.text}",
          "type": cardNumberController.text.startsWith('8600')
              ? 'UzCard'
              : cardNumberController.text.startsWith('9860')
                  ? 'Humo'
                  : cardNumberController.text.startsWith('4')
                      ? 'Visa'
                      : 'Other',
        },
      );
    }
  }

  @override
  void dispose() {
    cardNameController.dispose();
    cardNumberController.dispose();
    expiryMonthController.dispose();
    expiryYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text("Add card"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Card Number
            TextFormField(
              controller: cardNumberController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.credit_card),
                labelText: 'Card number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter the card number";
                }
                RegExp regExp = RegExp(r'^\d+$');
                if (!regExp.hasMatch(value.trim())) {
                  return "Please, enter a valid card number";
                }
                return null;
              },
            ),
            10.height,

            /// Card Name
            TextFormField(
              controller: cardNameController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.credit_card),
                labelText: 'Card name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please, enter the card name";
                }
                return null;
              },
            ),
            10.height,

            /// Expiry
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 140,

                  /// Month
                  child: TextFormField(
                    controller: expiryMonthController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(2)],
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.credit_card),
                      labelText: 'Month',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Enter month";
                      }

                      RegExp regExp = RegExp(r'^\d+$');
                      if (!regExp.hasMatch(value.trim()) ||
                          int.parse(value) > 12 ||
                          int.parse(value) < 1) {
                        return "Enter a valid month";
                      }
                      return null;
                    },
                  ),
                ),
                3.width,
                SizedBox(
                  width: 140,

                  /// Year
                  child: TextFormField(
                    controller: expiryYearController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.credit_card),
                      labelText: 'Year',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Enter year";
                      }

                      RegExp regExp = RegExp(r'^\d+$');
                      if (!regExp.hasMatch(value.trim())) {
                        return "Enter a valid year";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: submit,
          child: const Text("Save"),
        ),
      ],
    );
  }
}
