import 'package:davr_mobile/controllers/users_controller.dart';
import 'package:davr_mobile/models/user.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                leading: const Icon(Icons.person),
                title: Text(
                  user == null ? "Noma'lum" : user!.fullName,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                tileColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text("Sozlamalar"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  tileColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
