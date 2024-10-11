import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/configs/theme.dart';
import 'package:proyecto_programovil_g3/pages/auth/login/login_page.dart';
import 'package:proyecto_programovil_g3/pages/auth/register/register_page.dart';
import 'package:proyecto_programovil_g3/pages/landing/landing_page.dart';
import 'package:proyecto_programovil_g3/pages/wrapper/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'qSale',
      theme:
          AppTheme.lightTheme(), // Usa el tema claro definido en app_theme.dart
      darkTheme:
          AppTheme.darkTheme(), // Usa el tema oscuro definido en app_theme.dart
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/wrapper': (context) => Wrapper(),
      },
    );
  }
}
