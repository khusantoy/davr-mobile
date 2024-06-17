
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../models/card.dart';
import '../../utils/extensions.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key, required this.karta, this.isThisCardChosen = false});

  final Karta karta;
  final bool isThisCardChosen;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(
            color: isThisCardChosen ? Colors.black : Colors.transparent,
            width: 5),
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, Random().nextInt(180), Random().nextInt(180),
              Random().nextInt(180)),
          Color.fromARGB(255, Random().nextInt(180), Random().nextInt(180),
              Random().nextInt(180)),
        ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            karta.bankName,
            style: GoogleFonts.arvo(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          4.height,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                karta.type,
                style: GoogleFonts.arvo(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                NumberFormat.simpleCurrency().format(karta.balance),
                style: GoogleFonts.arvo(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/sim.png",
                width: 34,
                height: 26,
                fit: BoxFit.fitHeight,
              ),
              Transform.rotate(
                angle: 33,
                child: const Icon(
                  CupertinoIcons.wifi,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatCardNumber(karta.cardNumber.toString()),
                style: GoogleFonts.arvo(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  letterSpacing: 2,
                ),
              ),
              Text(
                "${karta.expiryDate.split('-').first}/${karta.expiryDate.split('-').last}",
                style: GoogleFonts.arvo(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          // Text("",style: TextStyle(color: Colors.white,fontSize: 16),),
        ],
      ),
    );
  }
}
