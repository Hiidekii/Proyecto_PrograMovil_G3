import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/models/user.dart';
import 'package:proyecto_programovil_g3/services/user_service.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isButtonEnabled =
      false.obs; // Controla si el botón de login está habilitado
  var isPasswordVisible = false.obs; // Controla la visibilidad de la contraseña

  final UserService userService = UserService(); // Instancia de UserService

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

  // Función para manejar el clic en el botón de iniciar sesión
  Future<void> onLoginClick(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    // Validar si las credenciales son correctas
    Usuario? user = await userService.login(email, password);

    if (user != null) {
      // Si el usuario existe, navega a la pantalla de Home
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }
      // Si el usuario no existe o la contraseña es incorrecta
      Get.snackbar(
        "Error",
        "Correo o contraseña incorrectos",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red, // Cambia el color de fondo
        colorText: Colors.white, // Cambia el color del texto
        duration: Duration(seconds: 3), // Duración de 3 segundos
        margin: EdgeInsets.all(10), // Añadir margen si lo deseas
        borderRadius: 8, // Añadir borde redondeado
        icon: const Icon(Icons.error, color: Colors.white), // Icono opcional
      );
    }
  }

  // Función para manejar el clic en el botón de registro
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
