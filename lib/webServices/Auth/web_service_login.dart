import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/models/login_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceLogin implements WebServiceProtocol {
  @override
  EndPoint get endPoint => EndPoint.login;
  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  Future<BaseResponse<LoginResponse>> fetchData(
      String email, String password) async {
    final body = {
      'email': email,
      'password': password,
    };
    try {
      final response = await NetworkManager().requestWith(
        endPoint: endPoint,
        method: httpMethod,
        body: body,
      );
      return BaseResponse.fromJson(response, LoginResponse.fromJson);
    } catch (error) {
      throw Exception('Error al realizar el login: $error');
    }
  }
}
