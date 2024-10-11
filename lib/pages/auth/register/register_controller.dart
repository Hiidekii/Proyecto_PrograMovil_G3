import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void onLoginClick(BuildContext context) async {
    Navigator.pushReplacementNamed(context, "/login");
  }

  void onRegisterClick(BuildContext context) async {
    print('onRegister click');
  }
}
