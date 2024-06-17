import 'package:davr_mobile/controllers/users_controller.dart';
import 'package:davr_mobile/main.dart';
import 'package:davr_mobile/models/user.dart';
import 'package:davr_mobile/services/auth_http_services.dart';
import 'package:davr_mobile/views/widgets/edit_user_dialog.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UsersController usersController = UsersController();
  User? user;

  @override
  void initState() {
    super.initState();
    usersController.getUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  void editUser(User user) async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return EditUserDialog(user: user);
      },
    );

    if (data != null) {
      await usersController.editUser(
        user.id,
        data['fullName'],
        data['email'],
        data['passportId'],
      );
      setState(() {
        usersController.getUser();
      });
    }
  }

  void deleteUser() async {
    final response = await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Ishonchingiz komilmi?"),
          content: const Text(
              "Agar siz rozilik bildirsangiz, tizimdan barcha ma'lumotlaringiz o'chiriladi."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Bekor qilish"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Ha, ishonchim komil"),
            ),
          ],
        );
      },
    );
    if (response != null) {
      if (response) {
        await usersController.deleteUser(user!.id);
        purgeRemove();
      }
    }
  }

  void purgeRemove() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/register',
      (Route<dynamic> route) => false,
    );
    AuthHttpServices.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        actions: [
          IconButton(
            onPressed: user != null ? () => editUser(user!) : null,
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return const MyApp();
                  },
                ),
                (Route<dynamic> route) => false,
              );
              return AuthHttpServices.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: user == null
          ? const Center(
              child: Text("Ma'lumotlar yuklanmadi"),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        user!.fullName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Elektron pochta"),
                        Text(user!.email),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Pasport seriyasi va raqami"),
                        Text(user!.passportId)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: deleteUser,
                      child: const Text(
                        "Hisobni o'chirish",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
