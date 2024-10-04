import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFF5E5C0);
  static const Color secondaryColor = Color(0xFF615049);

  // Colores de fondo
  static const Color lightBackgroundColor = Color(0xFFF5E5C0); // Fondo claro
  static const Color darkBackgroundColor = Color(0xFF28242c); // Fondo oscuro

  static const Color textColor = Color(0xFF262F34);

  // Método para obtener el color del texto según el tema
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white // Color para el tema oscuro
        : textColor;
  }

  // Método para obtener el color gris del texto
  static Color getTextGrayColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? lightBackgroundColor // Color de fondo claro para el tema oscuro
        : secondaryColor;
  }

  // Método para obtener el color de los botones
  static Color getButtonColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textColor // Color para el tema oscuro
        : Colors.white;
  }

  // Método para obtener el color de fondo
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackgroundColor // Color de fondo oscuro
        : lightBackgroundColor; // Color de fondo claro
  }
}
