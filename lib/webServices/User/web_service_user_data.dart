import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/models/user_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceUserData implements WebServiceProtocol {
  @override
  EndPoint get endPoint => EndPoint.userData;
  @override
  HTTPMethod get httpMethod => HTTPMethod.get;

  Future<BaseResponse<User>> fetchData(String token) async {
    final headers = {
      'Authorization': 'Token $token',
    };
    try {
      final response = await NetworkManager().requestWith(
        endPoint: endPoint,
        method: httpMethod,
        headers: headers,
      );
      print("USER DATA $response");
      return BaseResponse.fromJson(response, User.fromJson);
    } catch (error) {
      throw Exception('Error al traer los datos del usuario: $error');
    }
  }
}
