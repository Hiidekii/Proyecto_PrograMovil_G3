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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'qSale',
      theme:
          AppTheme.lightTheme(), // Usa el tema claro definido en app_theme.dart
      darkTheme:
          AppTheme.darkTheme(), // Usa el tema oscuro definido en app_theme.dart
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/wrapper': (context) => Wrapper(),
      },
    );
  }
}
