import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/auth/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginController control = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Image.asset(
                    'assets/images/shaka_logo.png',
                    height: 150,
                  ),
                  const SizedBox(height: 40),
                  // Container gris
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Correo Electrónico',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: control.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'ejemplo@correo.com',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Contraseña',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => TextField(
                            controller: control.passwordController,
                            obscureText: !control.isPasswordVisible.value,
                            decoration: InputDecoration(
                              hintText: 'Ingrese su contraseña',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  control.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  control.togglePasswordVisibility();
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: control.isButtonEnabled.value
                                  ? () {
                                      control.onLoginClick(context);
                                      // Limpiar los controladores de texto después de iniciar sesión
                                      control.emailController.clear();
                                      control.passwordController.clear();
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              child: const Text('Iniciar sesión'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text('o'),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              control.onRegisterClick(
                                  context); // Acción al hacer clic en el texto
                            },
                            child: const Text(
                              'Crear una cuenta',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(
                                    0xFF8A2BE2), // Color morado (puedes usar tu color preferido)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
