import 'package:davr_mobile/controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class IdentificationScreen extends StatefulWidget {
  const IdentificationScreen({super.key});

  @override
  State<IdentificationScreen> createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> {
  final usersController = UsersController();
  final _formKey = GlobalKey<FormState>();

  String? fullName, passportId;

  void saveData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await usersController.addUser(fullName!, passportId!);
        Navigator.pushReplacementNamed(context, '/success');
      } catch (e) {
        String message = e.toString();

        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Nimadir xato"),
              content: Text(message),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Identifikatsiya"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  width: 200.w,
                  height: 200.h,
                  child: Lottie.asset("assets/identification.json"),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Ism-familiya",
                    prefixIcon: Icon(Icons.account_box),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Ism-Familiyangizni kiriting";
                    }

                    return null;
                  },
                  onSaved: (newValue) {
                    // save fullName
                    fullName = newValue;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Pasport seriyasi va raqami",
                    prefixIcon: Icon(Icons.badge),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Passport seriyasi va raqamni kiriting";
                    } else {
                      final emailRegex = RegExp(r'^[A-Z]{2}\d{7}$');
                      if (!emailRegex.hasMatch(value)) {
                        return "Ma'lumot xato. Format(AB1234567)";
                      }
                    }

                    return null;
                  },
                  onSaved: (newValue) {
                    // save email
                    passportId = newValue;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed: saveData,
                    child: const Text("Saqlash"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
