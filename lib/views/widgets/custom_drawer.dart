import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:davr_mobile/controllers/users_controller.dart';
import 'package:davr_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final UsersController usersController = UsersController();
  final savedThemeMode = AdaptiveTheme.getThemeMode();
  User? user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final fetchedUser = await usersController.getUser();
    setState(() {
      user = fetchedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
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
                tileColor:
                    AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                        ? Colors.black
                        : Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  leading: const Icon(Icons.settings),
                  title: const Text("Sozlamalar"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  tileColor:
                      AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                          ? Colors.black
                          : Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
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
