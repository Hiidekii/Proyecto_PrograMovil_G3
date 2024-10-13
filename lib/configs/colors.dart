import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFFDF4E9);
  //PALETTE COLORS
  static const Color yellow = Color(0xFFF6A701);
  static const Color red = Color(0xFFE05C2C);
  static const Color pink = Color(0xFFEEB0D4);
  static const Color blue = Color(0xFF1EBAFF);
  static const Color cream = Color(0xFFFDF4E9);
  static const Color Osbcream = Color.fromARGB(255, 236, 236, 236);

  //SOFT COLORS
  static const Color softYellow = Color(0xFFF5E5C0);
  static const Color softRed = Color(0xFFEAA890);
  static const Color softPink = Color(0xFFF1D2E4);
  static const Color softBlue = Color(0xFF89D7FA);
  static const Color softGray = Color(0xFF8D8B8F);
  static const Color softBlack = Color(0xFF554E5A);

  static const Color secondaryColor = Color(0xFF615049);

  // Colores de fondo
  static const Color lightBackgroundColor = Color(0xFFFDF4E9); // Fondo claro
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

  // Método para obtener el color de bordes
  static Color getBorderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? softGray // Borde gris suave para modo oscuro
        : softGray; // Borde gris suave para modo claro
  }

// Método para obtener el color de bordes enfocados
  static Color getFocusedBorderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? blue // Color azul brillante para modo oscuro
        : blue; // Color azul brillante para modo claro
  }
}
