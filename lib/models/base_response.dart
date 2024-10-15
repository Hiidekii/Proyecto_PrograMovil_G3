import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class BaseResponse<T> {
  final bool success;
  final T data;

  BaseResponse({required this.success, required this.data});

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return BaseResponse<T>(
      success: json['success'],
      data: fromJsonT(json['data']),
    );
  }
}
