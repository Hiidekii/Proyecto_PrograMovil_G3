import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  //Se dejara para conexctar despues
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  // logo
                  Image.asset(
                    'lib/images/logo_ulima.png',
                    width: 400,
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  // welcome back, you've been missed!
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withOpacity(0.8), // Opacidad del fondo blanco
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Bienvenido a qSale!',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 25),
                        // username textfield
                        TextField(
                          controller: usernameController,
                          //hintText: 'Codigo',
                          obscureText: false,
                        ),
                        const SizedBox(height: 10),
                        // password textfield
                        TextField(
                          controller: passwordController,
                          //hintText: 'Clave',
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        // forgot password?
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Olvidaste tu contraseña?',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        // sign in button
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Iniciar Sesion"),
                        ),
                        const SizedBox(height: 30),
                        // not a member? register now
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No estas registrado?',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'Registrate ahora',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}