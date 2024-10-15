import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/webServices/Auth/web_service_login.dart';
import 'package:proyecto_programovil_g3/webServices/User/web_service_user_data.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isButtonEnabled =
      false.obs; // Controla si el botón de login está habilitado
  var isPasswordVisible = false.obs; // Controla la visibilidad de la contraseña

  final GetStorage storage = GetStorage(); // Instancia de GetStorage
  final webServiceLogin = WebServiceLogin();
  final webServiceUserData = WebServiceUserData();
  @override
  void onInit() {
    super.onInit();
    // Escuchar cambios en los campos de texto
    emailController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  // Función para validar el formato del correo electrónico
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _validateForm() {
    String email = emailController.text;
    String password = passwordController.text;

    isButtonEnabled.value = _isValidEmail(email) && password.isNotEmpty;
  }

  // Función para alternar la visibilidad de la contraseña
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> onLoginClick(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    try {
      final loginResponse = await webServiceLogin.fetchData(email, password);

      if (loginResponse.success) {
        final token = loginResponse.data.token;
        storage.write('token', token);
        Navigator.pushReplacementNamed(context, "/wrapper");
      } else {
        if (Get.isSnackbarOpen) {
          Get.closeAllSnackbars();
        }

        Get.snackbar(
          "Error",
          "Correo o contraseña incorrectos",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(10),
          borderRadius: 8,
          icon: const Icon(Icons.error, color: Colors.white),
        );
      }
    } catch (e) {
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }
      Get.snackbar(
        "Error",
        "Usuario o Clave incorrecta",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
        icon: const Icon(Icons.error, color: Colors.white),
      );
    }
  }

  void onRegisterClick(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/register");
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
