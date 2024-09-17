import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/theme.dart';
import 'package:proyecto_programovil_g3/pages/auth/login/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          AppTheme.lightTheme(), // Usa el tema claro definido en app_theme.dart
      darkTheme:
          AppTheme.darkTheme(), // Usa el tema oscuro definido en app_theme.dart
      //home: HomePage(), // Tu página principal
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => const Placeholder(),
        '/home': (context) => const Placeholder(),
      },
    );
  }
}