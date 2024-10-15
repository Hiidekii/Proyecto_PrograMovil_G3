import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class LoginResponse {
  final String? token;
  final String? error;
  LoginResponse({required this.token, required this.error});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        token: json['token'] as String?, error: json['error'] as String?);
  }
}
