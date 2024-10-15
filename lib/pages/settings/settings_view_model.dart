import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  // Propiedades del usuario
  String _userName = "Nombre del Usuario";
  String _userEmail = "usuario@example.com";
  String _userImageUrl = "assets/img/E1.png";

  // Propiedades de configuración
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  // Getters
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userImageUrl => _userImageUrl;

  bool get notificationsEnabled => _notificationsEnabled;
  bool get darkModeEnabled => _darkModeEnabled;

  // Setters
  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    _darkModeEnabled = value;
    notifyListeners();
  }
}
