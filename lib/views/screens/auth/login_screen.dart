import 'dart:async';
import 'package:davr_mobile/services/auth_http_services.dart';
import 'package:davr_mobile/views/screens/auth/forgot_password_screen.dart';
import 'package:davr_mobile/views/screens/auth/register_screen.dart';
import 'package:davr_mobile/views/screens/home_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();

  bool isLoading = false;
  bool hidePasswordField = true;

  String? email;
  String? password;

  void checkExpire() {
    Timer(const Duration(seconds: 3600), handleTimeout);
  }

  void handleTimeout() {
    AuthHttpServices.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => const LoginScreen(),
      ),
    );
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });

      try {
        await _authHttpServices.login(email!, password!);
        checkExpire();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => const HomeScreen(),
          ),
        );
      } on ClientException {
        showDialog(
          context: context,
          builder: (ctx) {
            return const AlertDialog(
              title: Text("Tarmoq xatosi"),
              content: Text("Internetga ulanishni tekshiring"),
            );
          },
        );
      } catch (e) {
        String message = e.toString();

        if (e.toString().contains("INVALID_LOGIN_CREDENTIALS")) {
          message = "Kiritilgan ma'lumotlarni qaytadan tekshirib ko'ring";
        }

        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Nimadir xato"),
              content: Text(message),
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tizimga kirish"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  width: 200.w,
                  height: 200.h,
                  child: Lottie.asset("assets/login.json"),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Elektron pochta",
                    prefixIcon: Icon(Icons.email),
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
                  height: 20.h,
                ),
                TextFormField(
                  obscureText: hidePasswordField,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Parol",
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePasswordField = !hidePasswordField;
                        });
                      },
                      icon: Icon(hidePasswordField
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Parolingizni kiriting";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    // save password
                    password = newValue;
                  },
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Parolni unutdingizmi?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 45.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          onPressed: submit,
                          child: const Text("Kirish"),
                        ),
                      ),
                SizedBox(
                  height: 20.h,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Sizda hisob mavjud emasmi? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "Ro'yhatdan o'tish",
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const RegisterScreen(),
                              ),
                            );
                          },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
