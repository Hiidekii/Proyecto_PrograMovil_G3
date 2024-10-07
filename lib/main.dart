import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proyecto_programovil_g3/configs/theme.dart';
import 'package:proyecto_programovil_g3/pages/login/login_page.dart';
import 'package:proyecto_programovil_g3/pages/register/register_screen.dart';
import 'package:proyecto_programovil_g3/pages/wrapper/wrapper.dart';

void main() async {
  runApp(MyApp());
  await initializeDateFormatting('es_ES', null);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'qSale',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/wrapper': (context) => Wrapper(onToggleTheme: _toggleTheme),
      },
    );
  }
}
