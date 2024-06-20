import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

import '../../../controllers/cards_controller.dart';
import '../../../models/payment_departments.dart';
import '../../../models/sim_contact.dart';
import 'widgets/payment_money.dart';

class PaymentSim extends StatefulWidget {
  final String paymentType;
  final SimInternetPayment simCard;

  const PaymentSim(
      {super.key, required this.simCard, required this.paymentType});

  @override
  State<PaymentSim> createState() => _PaymentSimState();
}

class _PaymentSimState extends State<PaymentSim> {
  final phoneNumber = TextEditingController();
  final money = TextEditingController();
  final cardsController = CardsController();
  Color color = Colors.red;
  bool phoneNumberIsTrue = false;
  bool summaIsTrue = false;
  String? error;
  String? sumError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            widget.simCard.typeName,
            style: const TextStyle(
                fontFamily: "Franklin", fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                        color: AdaptiveTheme.of(context).mode ==
                                AdaptiveThemeMode.dark
                            ? Colors.black
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey),
                        image: DecorationImage(
                            image: NetworkImage(widget.simCard.imgUrl))),
                  ),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          widget.simCard.typeName,
                          style: const TextStyle(
                              fontFamily: "Franklin",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.simCard.typeName.toLowerCase(),
                        style: const TextStyle(
                            fontFamily: "Franklin",
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AdaptiveTheme.of(context).mode ==
                                AdaptiveThemeMode.dark
                            ? Colors.black
                            : Colors.grey.shade300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.simCard.paymentType,
                          style: const TextStyle(
                              fontFamily: "Franklin",
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        widget.paymentType == 'phone' ||
                                widget.paymentType == 'home'
                            ? Row(
                                children: [
                                  const Text(
                                    "+998",
                                    style: TextStyle(
                                      fontFamily: "Franklim",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      onChanged: (value) {
                                        if (value.length > 1) {
                                          if (!widget.simCard.callCode.contains(
                                              value.substring(0, 2))) {
                                            setState(() {
                                              error =
                                                  'Bu no togri operator kodi';
                                            });
                                          } else {
                                            setState(() {
                                              error = null;
                                            });
                                          }
                                        }

                                        if (value.length != 9) {
                                          setState(() {
                                            error =
                                                'No togri formatdagi raqam kiritildi';
                                          });
                                        }
                                        try {
                                          int numb = int.parse(value);
                                          setState(() {
                                            if (value.length == 9 &&
                                                widget.simCard.callCode
                                                    .contains(value.substring(
                                                        0, 2))) {
                                              color = Colors.green;
                                              error = null;
                                              phoneNumberIsTrue = true;
                                            }
                                          });
                                        } catch (e) {
                                          setState(() {
                                            error =
                                                'Telefon raqam faqat raqamlardan iborat bolishi kerak';
                                          });
                                        }
                                      },
                                      controller: phoneNumber,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        errorText: error,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Icon(
                                    Icons.sim_card,
                                    color: color,
                                  )
                                ],
                              )
                            : const SizedBox(),
                        widget.paymentType == 'wifi' ||
                                widget.paymentType == 'platform' ||
                                widget.paymentType == 'teach' ||
                                widget.paymentType == 'taxi'
                            ? TextFormField(
                                onChanged: (value) {
                                  if (value == null || value.isEmpty) {
                                    setState(() {
                                      error = 'Login bosh bolmasligi kerak';
                                      phoneNumberIsTrue = false;
                                    });
                                  } else {
                                    setState(() {
                                      error = null;
                                    });
                                  }

                                  if (value.length < 6) {
                                    setState(() {
                                      error =
                                          "Login kamida 6 ta belgidan iborat bolishi kerak";
                                      phoneNumberIsTrue = false;
                                    });
                                  } else {
                                    setState(() {
                                      error = null;
                                    });
                                  }

                                  try {
                                    int numb = int.parse(value);
                                    setState(() {
                                      if (value.length > 5) {
                                        phoneNumberIsTrue = true;
                                        error = null;
                                      } else {
                                        phoneNumberIsTrue = false;
                                      }
                                    });
                                  } catch (e) {
                                    setState(() {
                                      error =
                                          'Login ramamlardan iborat bolishi kerak';
                                      phoneNumberIsTrue = false;
                                    });
                                  }
                                },
                                controller: phoneNumber,
                                decoration: InputDecoration(
                                    errorText: error,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: widget.simCard.paymentType),
                              )
                            : const SizedBox(),
                        widget.paymentType == 'tv' ||
                                widget.paymentType == 'work' ||
                                widget.paymentType == 'country' ||
                                widget.paymentType == 'ipPhone'
                            ? TextFormField(
                                onChanged: (value) {
                                  if (value == null || value.isEmpty) {
                                    setState(() {
                                      error = 'Login bosh bolmasligi kerak';
                                      phoneNumberIsTrue = false;
                                    });
                                  } else {
                                    setState(() {
                                      error = null;
                                    });
                                  }

                                  if (value.length < 6) {
                                    setState(() {
                                      error =
                                          "Login kamida 6 ta belgidan iborat bolishi kerak";
                                      phoneNumberIsTrue = false;
                                    });
                                  } else {
                                    setState(() {
                                      error = null;
                                    });
                                  }

                                  if (value.length > 5) {
                                    phoneNumberIsTrue = true;
                                    error = null;
                                  } else {
                                    phoneNumberIsTrue = false;
                                  }
                                },
                                controller: phoneNumber,
                                decoration: InputDecoration(
                                    errorText: error,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    hintText: widget.simCard.paymentType),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AdaptiveTheme.of(context).mode ==
                                AdaptiveThemeMode.dark
                            ? Colors.black
                            : Colors.grey.shade300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Summa",
                          style: TextStyle(
                              fontFamily: "Franklin",
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (value) async {
                            final data = await cardsController.getCards();

                            try {
                              int numb = int.parse(value);
                              if (numb < 500) {
                                setState(() {
                                  sumError = 'Summa kamida 500 bolishi kerak';
                                });
                              } else if (numb > 1500000) {
                                setState(() {
                                  sumError =
                                      'Summa maksimum 1500000 bolishi kerak';
                                });
                              } else {
                                setState(() {
                                  summaIsTrue = true;
                                  sumError = null;
                                });
                              }
                            } catch (e) {
                              setState(() {
                                sumError =
                                    'Iltimos summani raqamlar bilan kiriting';
                              });
                            }
                          },
                          controller: money,
                          decoration: InputDecoration(
                              errorText: sumError,
                              hintText: "500 dan 1500000 so'mgacha",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: phoneNumberIsTrue && summaIsTrue
            ? InkWell(
                onTap: () async {
                  double sum = double.parse(money.text);
                  await showDialog(
                    context: context,
                    builder: (ctx) {
                      return PaymentMoney(
                        paymentDepartments: PaymentDepartments(
                            amount: sum,
                            date: DateTime.now(),
                            servicesName: widget.simCard.typeName,
                            servicesAccount: phoneNumber.text,
                            fromCard: '8600969685857474',
                            userId: ''),
                      ); //aka bu yerda kartani bervorasiz
                    },
                  );
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "O'tkazish",
                      style: TextStyle(
                        fontFamily: "Franklin",
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox());
  }
}
