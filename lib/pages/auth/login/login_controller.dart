import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/models/user.dart';
import 'package:proyecto_programovil_g3/services/user_service.dart';

class LoginController extends GetxController {
  //Definir Controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxString mesage = ''.obs;

  //Definir funciones
  void goHome(BuildContext context) async {
    print('estoy en el controlador');
    UserService service = UserService();
    User? user =
        await service.login(usernameController.text, passwordController.text);
    if (usernameController.text == '' || passwordController.text == '') {
      this.mesage.value = 'Error: Debe de llenar usuario y contraseña';
      Future.delayed(Duration(seconds: 3));
    } else {
      print(usernameController.text);
      print(passwordController.text);
      mesage.value = 'Login Incorrecto papu';
      print(mesage.value);
    }
  }
}
