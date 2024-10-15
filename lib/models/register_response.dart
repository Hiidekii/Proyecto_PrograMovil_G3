import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class RegisterResponse {
  final String? message;
  final String? error;

  RegisterResponse({this.message, this.error});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] as String?,
      error: json['error'] as String?,
    );
  }
}
