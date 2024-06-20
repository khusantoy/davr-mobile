import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:davr_mobile/controllers/users_controller.dart';
import 'package:davr_mobile/generated/assets.dart';
import 'package:davr_mobile/main.dart';
import 'package:davr_mobile/models/user.dart';
import 'package:davr_mobile/services/auth_http_services.dart';
import 'package:davr_mobile/views/widgets/edit_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

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

  Future<void> _fetchUser() async {
    final fetchedUser = await usersController.getUser();
    setState(() {
      user = fetchedUser;
    });
  }

  void editUser(User user) async {
    final data = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) {
        return EditUserDialog(user: user);
      },
    );

    if (data != null) {
      await usersController.editUser(
        user.id,
        data['fullName'],
        // data['email'],
        data['passportId'],
      );
      await _fetchUser();
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
        await usersController.deleteUser(user!.id, user!.userId);
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
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: 200.w,
                      height: 200.h,
                      child: Lottie.asset(Assets.lottiesHello),
                    ),
                    Text(
                      user!.fullName,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AdaptiveTheme.of(context).mode ==
                                AdaptiveThemeMode.dark
                            ? Colors.black
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Elektron pochta"),
                          Text(user!.email),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AdaptiveTheme.of(context).mode ==
                                AdaptiveThemeMode.dark
                            ? Colors.black
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Pasport seriyasi va raqami"),
                          Text(user!.passportId)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
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
            ),
    );
  }
}
