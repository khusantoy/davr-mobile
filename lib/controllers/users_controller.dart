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

  Future<void> editUser(
    String id,
    String fullName,
    String email,
    String passportId,
  ) async {
    await userHttpServices.editUser(id, fullName, email, passportId);
  }

  Future<void> deleteUser(String id, String userId) async {
    await userHttpServices.deleteUser(id, userId);
  }
}
