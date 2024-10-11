import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/pages/landing/landing_controller.dart';

class LandingPage extends StatelessWidget {
  LandingController control = Get.put(LandingController());

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                Image.asset(
                  'assets/images/landing_slogan.png',
                  height: 150,
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white, // Fondo blanco
                    borderRadius:
                        BorderRadius.circular(10), // Bordes redondeados
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
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      control.onContinueClick(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text('Iniciar Sesion / Crear Cuenta'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
