import 'package:davr_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditUserDialog extends StatefulWidget {
  final User? user;
  const EditUserDialog({super.key, required this.user});

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passportIdController = TextEditingController();

  String? fullName;
  String? email;
  String? passportId;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      fullName = widget.user!.fullName;
      email = widget.user!.email;
      passportId = widget.user!.passportId;

      emailController.text = email!;
      fullNameController.text = fullName!;
      passportIdController.text = passportId!;
    }
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.pop(context, {
        "fullName": fullName,
        "email": email,
        "passportId": passportId,
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text("Ma'lumotlarini yangilash"),
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Elektron pochta",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Elektron pochtangizni kiriting";
                } else {
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return "Elektron pochta xato";
                  }
                }

                return null;
              },
              onSaved: (newValue) {
                // save email
                email = newValue;
              },
            ),
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
              controller: fullNameController,
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
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
              controller: passportIdController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Pasport seriyasi va raqami",
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Bekor qilish"),
        ),
        FilledButton(
          onPressed: submit,
          child: const Text("Yangilash"),
        ),
      ],
    );
  }
}
