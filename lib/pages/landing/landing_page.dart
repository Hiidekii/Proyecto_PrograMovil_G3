import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/landing/landing_controller.dart';

class LandingPage extends StatelessWidget {
  LandingController control = Get.put(LandingController());

  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/login_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            // Asegura que el contenido esté centrado
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centramos verticalmente
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Centramos horizontalmente
                children: [
                  Image.asset(
                    'assets/images/landing_slogan.png',
                    height: 180,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor, // Fondo blanco
                      borderRadius:
                          BorderRadius.circular(20), // Bordes redondeados
                    ),
                    child: const Text(
                      "Únete a los mega eventos, crucial, determinante!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black, // Texto negro
                      ),
                      textAlign: TextAlign.center, // Alineado al centro
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 290,
                    child: ElevatedButton(
                      onPressed: () {
                        control.onContinueClick(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: const TextStyle(fontSize: 16),
                        backgroundColor:
                            AppColors.yellow, // Color amarillo para el botón
                      ),
                      child: const Text('Iniciar Sesion / Crear Cuenta'),
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
