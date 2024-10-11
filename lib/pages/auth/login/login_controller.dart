import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onLoginClick(BuildContext context) async {
    print('onLogin click');
  }

  void onRegisterClick(BuildContext context) async {
    Navigator.pushReplacementNamed(context, "/register");
  }
}
