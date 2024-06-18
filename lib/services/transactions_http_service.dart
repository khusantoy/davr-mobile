import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction.dart';

class TransactionsHttpService {
  Future<void> sendMoney(
      int fromCardNumber, int toCardNumber, double amount) async {
    // URLs for cards and transactions
    const String cardsUrl =
        'https://exam-team-5-default-rtdb.firebaseio.com/cards2.json';
    const String transactionsUrl =
        'https://exam-team-5-default-rtdb.firebaseio.com/transactions2.json';

    // Fetch the current card data
    final cardsResponse = await http.get(Uri.parse(cardsUrl));
    if (cardsResponse.statusCode != 200) {
      if (kDebugMode) {
        print('Failed to load cards data');
      }
      return;
    }
    final Map<String, dynamic> cards = json.decode(cardsResponse.body);

    // Find the cards based on cardNumber
    Map<String, dynamic>? fromCard;
    Map<String, dynamic>? toCard;

    // Loop through all cards to find matching ones
    cards.forEach((key, value) {
      if (value['cardNumber'] == fromCardNumber) {
        fromCard = value; // No need to copy here, modification is intended
      } else if (value['cardNumber'] == toCardNumber) {
        toCard = value;
      }
    });

    // Check if cards were found
    if (fromCard == null || toCard == null) {
      if (kDebugMode) {
        print('One or both cards not found');
      }
      return;
    }

    // Check if fromCard has enough balance
    if (fromCard!['balance'] < amount) {
      if (kDebugMode) {
        print('Insufficient balance on the sender\'s card');
      }
      return;
    }

    // Perform the transaction - Update balances directly within loop
    fromCard!['balance'] -= amount;
    toCard!['balance'] += amount;

    // Prepare updated cards data - No need to create a separate map
    final Map<String, dynamic> updatedCards = cards;

    // Update cards data in Firebase
    final updateResponse = await http.put(
      Uri.parse(cardsUrl),
      body: json.encode(updatedCards),
    );
    if (updateResponse.statusCode != 200) {
      throw 'Failed to update cards data';
    }

    // Log the transaction
    final transaction = {
      'amount': amount,
      'date': DateTime.now().toIso8601String(),
      'fromCard': fromCardNumber,
      'fromId': fromCard!['customerId'],
      'toCard': toCardNumber,
      'toId': toCard!['customerId'],
    };

    final transactionsResponse = await http.post(
      Uri.parse(transactionsUrl),
      body: json.encode(transaction),
    );
    if (transactionsResponse.statusCode != 200) {
      // print('Failed to log the transaction');
      return;
    }

    if (kDebugMode) {
      print('Transaction successful!');
    }
    // print('Updated ${fromCard!['cardName']} balance: ${fromCard!['balance']}');
    // print('Updated ${toCard!['cardName']} balance: ${toCard!['balance']}');
  }

  Future<List<Transaction>> getReceives() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    Uri url = Uri.parse(
        'https://exam-team-5-default-rtdb.firebaseio.com/transactions2.json?orderBy="toId"&equalTo="$userId"');

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<Transaction> tushumlar = [];

    if (data != null) {
      data.forEach((key, value) {
        tushumlar.add(Transaction(
          id: key,
          amount: value['amount'],
          date: value['date'],
          fromCard: value['fromCard'],
          fromId: value['fromId'],
          toCard: value['toCard'],
          toId: value['toId'],
        ));
      });
    }
    // print("Tushumlar: $tushumlar");
    return tushumlar;
  }

  Future<List<Transaction>> getSends() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    Uri url = Uri.parse(
        'https://exam-team-5-default-rtdb.firebaseio.com/transactions2.json?orderBy="fromId"&equalTo="$userId"');

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<Transaction> jonatmalar = [];

    if (data != null) {
      data.forEach((key, value) {
        jonatmalar.add(Transaction(
          id: key,
          amount: value['amount'],
          date: value['date'],
          fromCard: value['fromCard'],
          fromId: value['fromId'],
          toCard: value['toCard'],
          toId: value['toId'],
        ));
      });
    }
    // print("Jonatmalar: $jonatmalar");
    return jonatmalar;
  }

//
//   Future<void> sendMoneyToCard(double amount, int toCard, String date) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String? fromId = sharedPreferences.getString("userId");
//     String? toId = await findCustomerIdByCardNumber(toCard);
//
//     Uri url = Uri.parse(
//         "https://exam-team-5-default-rtdb.firebaseio.com/transactions/$fromId.json");
//     final mapData = {
//       'amount': amount,
//       'card': toCard,
//       'date': date,
//     };
//     // Fetch existing JSON data
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final existingData = jsonDecode(response.body);
//
//       // Check if "to" key exists, create an empty list if not
//       if (existingData.containsKey('to')) {
//         existingData['to'].add(mapData);
//       } else {
//         existingData['to'] = [mapData];
//       }
//
//       // Encode the updated data back to JSON
//       final updatedJson = jsonEncode(existingData);
//
//       // Send the updated JSON back to the server
//       await http.put(url, body: updatedJson);
//       await addReceivedTransactions(toCard, mapData);
//     } else {
//       // Handle error case (e.g., failed to fetch existing data)
//       print('Error fetching existing data: ${response.statusCode}');
//     }
//   }
//
//   Future<void> addReceivedTransactions(int cardNumber, Map mapData) async {
//     final userId = await findCustomerIdByCardNumber(cardNumber);
//     Uri url = Uri.parse(
//         "https://exam-team-5-default-rtdb.firebaseio.com/transactions/$userId.json");
//     print(userId);
//     // final create = await http.patch(url, body: jsonEncode({'from':[]}));
//     // if (create.statusCode == 200) {
//     //   print(create.statusCode);
//     // }
//
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final existingData = jsonDecode(response.body);
//       print(existingData);
//
//       // Check if "to" key exists, create an empty list if not
//       if (existingData.containsKey('from')) {
//         existingData['from'].add(mapData);
//       } else {
//         existingData['from'] = [mapData];
//       }
//
//       // Encode the updated data back to JSON
//       final updatedJson = jsonEncode(existingData);
//
//       // Send the updated JSON back to the server
//       await http.put(url, body: updatedJson);
//     } else if (response.statusCode == 404) {
//       // Create a new transaction with custom ID if no existing data is found
//       final newTransactionData = {'from': [mapData]};
//       await http.put(url, body: jsonEncode(newTransactionData));
//     } else {
//       // Handle error case (e.g., failed to fetch existing data)
//       print('Error fetching existing data: ${response.statusCode}');
//     }
//   }
//
//   static const cardsUrl =
//       'https://exam-team-5-default-rtdb.firebaseio.com/cards2.json';
//
// // Function to fetch cards data
//   Future<Map<String, dynamic>> fetchCardsData() async {
//     final response = await http.get(Uri.parse(cardsUrl));
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load cards data');
//     }
//   }
//
// // Function to find the customer ID by card number
//   Future<String> findCustomerIdByCardNumber(int cardNumber) async {
//     final cardsData = await fetchCardsData();
//     for (var cardId in cardsData.keys) {
//       if (cardsData[cardId]['cardNumber'] == cardNumber) {
//         return cardsData[cardId]['customerId'];
//       }
//     }
//     throw Exception('Card number not found');
//   }
}
