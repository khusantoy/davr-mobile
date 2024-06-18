import 'package:flutter/material.dart';

import 'sim_contact.dart';

class PaymentsSaveModel{
  String name;
  Icon icon;
  List<SimInternetPayment> sims;

  PaymentsSaveModel({required this.name,required this.icon,required this.sims});
}