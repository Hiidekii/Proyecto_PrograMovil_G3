import 'package:flutter/material.dart';

class AppColors {
  //PALETTE COLORS
  static const Color yellow = Color(0xFFF6A701);
  static const Color red = Color(0xFFE05C2C);
  static const Color pink = Color(0xFFEEB0D4);
  static const Color blue = Color(0xFF1EBAFF);
  static const Color cream = Color(0xFFFDF4E9);

  //SOFT COLORS
  static const Color softYellow = Color(0xFFF4D592);
  static const Color softRed = Color(0xFFEAA890);
  static const Color softPink = Color(0xFFF1D2E4);
  static const Color softBlue = Color(0xFF89D7FA);
  static const Color softGray = Color(0xFF8D8B8F);

  static const Color primaryColor = Color(0xFFFF7F2A);
  static const Color secondaryColor = Color(0xFF615049);
  static const Color backgroundColor = Color(0xFFF1D3BC);
  static const Color textColor = Color(0xFF262F34);

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white // Color para el tema oscuro
        : textColor;
  }

  static Color getTextGrayColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? backgroundColor // Color para el tema oscuro
        : secondaryColor;
  }

  static Color getButtonColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textColor // Color para el tema oscuro
        : Colors.white;
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textColor // Color para el tema oscuro
        : Colors.white;
  }
}
