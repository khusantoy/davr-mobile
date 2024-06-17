import 'package:davr_mobile/controllers/users_controller.dart';
import 'package:flutter/material.dart';

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
        Navigator.pushReplacementNamed(context, '/home');
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ism-familiya",
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
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Pasport seriyasi va raqami",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Passport seriyasi va raqamni kiriting";
                  }

                  return null;
                },
                onSaved: (newValue) {
                  // save email
                  passportId = newValue;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
    );
  }
}
