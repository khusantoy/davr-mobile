import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/payment_departments.dart';

class PaymentHttpServices {
  final url = 'https://exam-team-5-default-rtdb.firebaseio.com';

  Future<void> pushPayment(PaymentDepartments payment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    final api = Uri.parse("https://exam-team-5-default-rtdb.firebaseio.com/payments.json");
    payment.userId = userId;
    final response = await http.post(
      api,
      body: jsonEncode(payment.toJson()),
    );

    Uri urlApi = Uri.parse(
        'https://exam-team-5-default-rtdb.firebaseio.com/cards2.json?orderBy="customerId"&equalTo="$userId"');

    final data = await http.get(urlApi);
    Map<String,dynamic> card = jsonDecode(data.body);
    List<String> id = card.keys.toList();
    print(card['${id[0]}']['balance']);
    double price = double.parse(card['${id[0]}']['balance']);
    // price -= payment.amount;
    print(price);
    // Uri patchUri = Uri.parse('https://exam-team-5-default-rtdb.firebaseio.com/cards2.json/${id[0]}.json');
    // final a = await http.get(urlApi);
    // print(a.body);
  }
}
