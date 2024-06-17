import 'package:davr_mobile/models/user.dart';
import 'package:davr_mobile/services/users_http_services.dart';

class UsersController {
  final userHttpServices = UsersHttpServices();

  Future<void> addUser(String fullName, String passportId) async {
    await userHttpServices.addUser(fullName, passportId);
  }

  Future<User?> getUser() async {
    return await userHttpServices.getUser();
  }
}
