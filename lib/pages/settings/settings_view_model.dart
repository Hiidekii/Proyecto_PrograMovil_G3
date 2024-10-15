import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/webServices/User/web_service_user_data.dart';

class SettingsViewModel extends ChangeNotifier {
  // Propiedades del usuario
  final GetStorage storage = GetStorage(); // Instancia de GetStorage
  final webServiceUserData = WebServiceUserData();
  String _userName;
  String _userEmail;
  String _userImageUrl;

  // Propiedades de configuración
  bool _notificationsEnabled;
  bool _darkModeEnabled;

  // Constructor para inicializar las propiedades
  SettingsViewModel({
    String userName = "Nombre del Usuario",
    String userEmail = "usuario@example.com",
    String userImageUrl = "assets/img/E1.png",
    bool notificationsEnabled = true,
    bool darkModeEnabled = false,
  })  : _userName = userName,
        _userEmail = userEmail,
        _userImageUrl = userImageUrl,
        _notificationsEnabled = notificationsEnabled,
        _darkModeEnabled = darkModeEnabled {
    _onAppear();
  }

  void _onAppear() async {
    final token = storage.read('token') ?? "";
    try {
      final response = await webServiceUserData.fetchData(token);
      if (response.success) {
        final userData = response.data;
        _userName = userData.username;
        _userEmail = userData.email;
        _userImageUrl = userData.thumbnail;
        notifyListeners();
      } else {
        print("ERROR");
      }
    } catch (e) {
      print(e.toString());
    }
  }

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
