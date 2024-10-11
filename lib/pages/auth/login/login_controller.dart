import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/models/user.dart';
import 'package:proyecto_programovil_g3/services/user_service.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isButtonEnabled =
      false.obs; // Controla si el botón de login está habilitado
  var isPasswordVisible = false.obs; // Controla la visibilidad de la contraseña

  final UserService userService = UserService(); // Instancia de UserService
  final GetStorage storage = GetStorage(); // Instancia de GetStorage

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

  // Validar que el formulario esté completo y correcto
  void _validateForm() {
    String email = emailController.text;
    String password = passwordController.text;

    // El botón se habilita solo si el correo es válido y la contraseña no está vacía
    isButtonEnabled.value = _isValidEmail(email) && password.isNotEmpty;
  }

  // Función para alternar la visibilidad de la contraseña
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> onLoginClick(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    Usuario? user = await userService.login(email, password);

    if (user != null) {
      // Si el usuario existe, navega a la pantalla de Home
      storage.write('user', user.toJson());
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
  }

  void onRegisterClick(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/register");
  }

  @override
  void onClose() {
    // Limpiar controladores cuando se destruya el controlador
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
