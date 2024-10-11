import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/configs/theme.dart';
import 'package:proyecto_programovil_g3/pages/auth/login/login_page.dart';
import 'package:proyecto_programovil_g3/pages/auth/register/register_page.dart';
import 'package:proyecto_programovil_g3/pages/landing/landing_page.dart';
import 'package:proyecto_programovil_g3/pages/wrapper/wrapper.dart';

void main() async {
  await GetStorage.init();
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
    return GetMaterialApp(
        title: 'qSale',
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
        initialRoute: '/',
        routes: {
          '/': (context) => LandingPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/wrapper': (context) => Wrapper(onToggleTheme: _toggleTheme),
        });
  }
}
