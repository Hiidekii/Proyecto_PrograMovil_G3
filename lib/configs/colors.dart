import 'package:flutter/material.dart';

class AppColors {
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
