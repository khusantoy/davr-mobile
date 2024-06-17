import 'dart:convert';

import 'package:davr_mobile/models/user.dart';
import 'package:davr_mobile/services/auth_http_services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsersHttpServices {
  final AuthHttpServices authHttpServices = AuthHttpServices();

  Future<void> addUser(String fullName, String passportId) async {
    Uri url =
        Uri.parse("https://exam-team-5-default-rtdb.firebaseio.com/users.json");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? userId = sharedPreferences.getString("userId");
    String? email = sharedPreferences.getString("email");

    await http.post(
      url,
      body: jsonEncode(
        {
          "userId": userId,
          "email": email,
          "fullName": fullName,
          "passportId": passportId,
        },
      ),
    );
  }

  Future<User?> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString("userId");
    Uri url = Uri.parse(
        "https://exam-team-5-default-rtdb.firebaseio.com/users.json?orderBy=\"userId\"&equalTo=\"$userId\"");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        String userKey = data.keys.first;
        Map<String, dynamic> userData = data[userKey];
        userData['id'] = userKey;
        print(userData['id']);
        User user = User.fromJson(userData);
        return user;
      } else {
        print("No user found with userId: $userId");
        return null;
      }
    } else {
      print("Error fetching user data: ${response.statusCode}");
      return null;
    }
  }

  Future<void> editUser(
    String id,
    String fullName,
    // String email,
    String passportId,
  ) async {
    Uri url = Uri.parse(
        "https://exam-team-5-default-rtdb.firebaseio.com/users/$id.json");

    Map<String, dynamic> userData = {
      "fullName": fullName,
      // "email": email,
      "passportId": passportId,
    };

    await http.patch(
      url,
      body: jsonEncode(userData),
    );
  }

  Future<void> deleteUser(String id, String userId) async {
    print(id);
    try {
      Uri url = Uri.parse(
          "https://exam-team-5-default-rtdb.firebaseio.com/users/$id.json");
      await http.delete(url);
    } catch (e) {
      print(e);
    }
  }
}
