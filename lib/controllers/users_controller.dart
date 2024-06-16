import 'package:davr_mobile/services/users_http_services.dart';

class UsersController {
  final userHttpServices = UsersHttpServices();

  Future<void> addUser() async {
    await userHttpServices.addUser();
  }
}
