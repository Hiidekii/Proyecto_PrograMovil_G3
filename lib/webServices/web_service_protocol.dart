import 'package:proyecto_programovil_g3/webServices/network_manager.dart';

abstract class WebServiceProtocol {
  EndPoint get endPoint;
  HTTPMethod get httpMethod;
}

abstract class JsonSerializable {
  factory JsonSerializable.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson no implementado');
  }
}
