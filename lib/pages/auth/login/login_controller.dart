import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Variables de estado para manejar la visibilidad de la contra y la activación del boton
  var isButtonEnabled = false.obs;
  var isPasswordVisible = false.obs;

  //Funcion init similar al init del viewmodel de Kotlin
  @override
  void onInit() {
    super.onInit();
    emailController
        .addListener(_validateForm); //Se empieza a escuchar ambos textos
    passwordController.addListener(_validateForm);
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); //Validamos si el texto es un correo
    return emailRegex.hasMatch(email);
  }

  void _validateForm() {
    String email = emailController.text;
    String password = passwordController.text;

    isButtonEnabled.value = _isValidEmail(email) &&
        password
            .isNotEmpty; //activamos el boton solo si ambos textfields estan completos
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value; //ojito pa ver la contra
  }

  void onLoginClick(BuildContext context) {
    print('onLogin click'); //todo: sessionStorage del user y navegación a home
  }

  void onRegisterClick(BuildContext context) {
    Navigator.pushReplacementNamed(
        context, "/register"); //navegacion a register una sola instancia
  }

  @override //limpiamos controladores al navegar
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
