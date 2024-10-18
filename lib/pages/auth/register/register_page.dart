import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/auth/register/register_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterController control = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        // Hace que el container ocupe todo el espacio disponible
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  // Nuevo Container gris
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius:
                          BorderRadius.circular(10), // Bordes redondeados
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final pickedImg = await picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (pickedImg != null) {
                                File imageFile = File(pickedImg.path);
                                List<int> imageBytes =
                                    await imageFile.readAsBytes();
                                String base64Image = base64Encode(imageBytes);
                                control.imageBase64.value = base64Image;
                              }
                            },
                            child: Obx(() {
                              return Container(
                                // Añadido contenedor para el borde
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.yellow, // Color del borde
                                    width: 3, // Ancho del borde
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage: control
                                          .imageBase64.value.isNotEmpty
                                      ? MemoryImage(base64Decode(
                                          control.imageBase64.value))
                                      : const AssetImage(
                                              'assets/images/placeholder_image.png')
                                          as ImageProvider,
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(
                            height: 20), // Espacio entre el avatar y el texto
                        const Text(
                          'Nombre de Usuario',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: control.usernameController,
                          decoration: const InputDecoration(
                            hintText: 'Ingrese su nombre de usuario',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 20),
                        const Text(
                          'Repetir Contraseña',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => TextField(
                            controller: control.confirmPasswordController,
                            obscureText:
                                !control.isConfirmPasswordVisible.value,
                            decoration: InputDecoration(
                              hintText: 'Repita su contraseña',
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  control.isConfirmPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  control.toggleConfirmPasswordVisibility();
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
                                      control.onRegisterClick(context);
                                    }
                                  : null, // El botón se deshabilita si no cumple las validaciones
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                textStyle: const TextStyle(fontSize: 16),
                              ),
                              child: const Text('Registrarse'),
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
                              control.onLoginClick(
                                  context); // Acción al hacer clic en el texto
                            },
                            child: const Text(
                              'Iniciar Sesión',
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
