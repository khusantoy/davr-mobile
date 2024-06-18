import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/payment_departments.dart';

class PaymentHttpServices {
  final url = 'https://exam-team-5-default-rtdb.firebaseio.com';

  Future<List<PaymentDepartments>> getPayments() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    Uri url = Uri.parse(
        'https://exam-team-5-default-rtdb.firebaseio.com/payments.json?orderBy="userId"&equalTo="$userId"');

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    List<PaymentDepartments> payments = [];

    if (data != null) {
      try {
        data.forEach((key, value) {
          payments.add(
            PaymentDepartments(
              amount: value['amount'],
              date: DateTime.parse(value['date']),
              servicesName: value['servicesName'],
              servicesAccount: value['servicesAccount'],
              userId: value['userId'],
              fromCard: value['fromCard'],
            ),
          );
        });
      } catch (e) {
        print(e);
      }
    }

    return payments;
  }

  Future<void> pushPayment(PaymentDepartments payment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    final api = Uri.parse(
        "https://exam-team-5-default-rtdb.firebaseio.com/payments.json");
    payment.userId = userId;
    final response = await http.post(
      api,
      body: jsonEncode(payment.toJson()),
    );

    Uri urlApi = Uri.parse(
        'https://exam-team-5-default-rtdb.firebaseio.com/cards2.json?orderBy="customerId"&equalTo="$userId"');

    final data = await http.get(urlApi);
    Map<String, dynamic> card = jsonDecode(data.body);
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
