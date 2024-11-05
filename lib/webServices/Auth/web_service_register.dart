import 'package:proyecto_programovil_g3/models/Auth/check_response.dart';
import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceRegister implements WebServiceProtocol {
  @override
  EndPoint get endPoint => EndPoint.register;
  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  Future<BaseResponse<CheckResponse>> fetchData(
    String username,
    String email,
    String password,
    String thumbnail,
  ) async {
    final body = {
      'username': username,
      'email': email,
      'password': password,
      'thumbnail': thumbnail,
    };
    try {
      final response = await NetworkManager().requestWith(
        endPoint: endPoint,
        method: httpMethod,
        body: body,
      );
      return BaseResponse.fromJson(
          response, (json) => CheckResponse.fromJson(json));
    } catch (error) {
      throw Exception('Error al realizar el login: $error');
    }
  }
}
