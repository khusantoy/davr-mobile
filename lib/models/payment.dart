import 'package:flutter/cupertino.dart';

import 'sim_contact.dart';

class Payment{
  Icon icon;
  String name;
  List<SimInternetPayment> payments;

  Payment({required this.icon,required this.name,required this.payments});
}