import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsersHttpServices {
  Future<void> addUser() async {
    Uri url = Uri.parse(
        "https://exam-team-5-default-rtdb.firebaseio.com/users.json");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? userId = sharedPreferences.getString("userId");

    await http.post(
      url,
      body: jsonEncode(
        {
          "userId": userId,
        },
      ),
    );
  }
}