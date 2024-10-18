import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/configs/theme.dart';
import 'package:proyecto_programovil_g3/pages/auth/login/login_page.dart';
import 'package:proyecto_programovil_g3/pages/auth/register/register_page.dart';
import 'package:proyecto_programovil_g3/pages/landing/landing_page.dart';
import 'package:proyecto_programovil_g3/pages/wrapper/wrapper.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  tz.initializeTimeZones();
  await GetStorage.init();

  await initializeDateFormatting('es_PE', null);

  runApp(MyApp());
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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('es'), // Spanish
        ],
        locale: const Locale('es', 'PE'),
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LandingPage(),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/wrapper': (context) => Wrapper(onToggleTheme: _toggleTheme),
        });
  }
}
