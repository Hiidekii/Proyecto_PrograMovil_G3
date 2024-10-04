import 'package:flutter/material.dart';
import 'colors.dart'; // Asegúrate de que este archivo esté correctamente importado

class AppTheme {
  // Define el tema claro
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor, // Configuración del primaryColor
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor, // Color de fondo de la AppBar
        foregroundColor:
            AppColors.textColor, // Color del texto e íconos de la AppBar
      ),
      textTheme: const TextTheme(
        displaySmall: TextStyle(
          color: AppColors.textColor,
          fontSize: 32.0, // Título grande en tema claro
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor:
              AppColors.textColor, // Color de fondo de los botones elevados
        ),
      ),
      scaffoldBackgroundColor: AppColors.lightBackgroundColor,
      // Puedes definir otros aspectos del tema aquí
    );
  }

  // Define el tema oscuro
  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor:
            AppColors.darkBackgroundColor, // Color de fondo de la AppBar
        foregroundColor: Colors.white, // Color del texto e íconos de la AppBar
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.red),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBackgroundColor,
          foregroundColor: AppColors
              .darkBackgroundColor, // Color de fondo de los botones elevados
        ),
      ),
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      // Puedes definir otros aspectos del tema aquí
    );
  }
}
