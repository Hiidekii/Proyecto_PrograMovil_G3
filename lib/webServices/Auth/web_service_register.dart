import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/models/register_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceRegister implements WebServiceProtocol {
  @override
  EndPoint get endPoint => EndPoint.register;
  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  Future<BaseResponse<RegisterResponse>> fetchData(
    String username,
    String email,
    String password,
  ) async {
    final body = {
      'username': username,
      'email': email,
      'password': password,
    };
    try {
      final response = await NetworkManager().requestWith(
        endPoint: endPoint,
        method: httpMethod,
        body: body,
      );
      return BaseResponse.fromJson(response, RegisterResponse.fromJson);
    } catch (error) {
      throw Exception('Error al realizar el login: $error');
    }
  }
}
