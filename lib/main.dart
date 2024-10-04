import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/theme.dart';
import 'package:proyecto_programovil_g3/pages/home/home_page.dart';
import 'package:proyecto_programovil_g3/pages/login/login_page.dart';
import 'package:proyecto_programovil_g3/pages/register/register_screen.dart';
import 'package:proyecto_programovil_g3/pages/wrapper/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // Estado para el modo oscuro

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode; // Cambia el estado del tema
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'qSale',
      theme: AppTheme.lightTheme(), // Tema claro
      darkTheme: AppTheme.darkTheme(), // Tema oscuro
      themeMode: _isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light, // Cambiar tema basado en el estado
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(), // Pasar la función
        '/register': (context) => RegisterScreen(),
        '/wrapper': (context) =>
            Wrapper(onToggleTheme: _toggleTheme), // Pasar la función
      },
    );
  }
}
