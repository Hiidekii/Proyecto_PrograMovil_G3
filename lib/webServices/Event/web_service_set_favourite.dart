import 'package:proyecto_programovil_g3/models/Auth/check_response.dart';
import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceSetFavourite implements WebServiceProtocol {
  @override
  EndPoint get endPoint => EndPoint.setFavourite;
  @override
  HTTPMethod get httpMethod => HTTPMethod.get;

  Future<BaseResponse<CheckResponse>> fetchData(
      String token, int eventID, bool newState) async {
    final headers = {
      'Authorization': 'Token $token',
    };
    final params = {
      'event_id': eventID,
      'new_state': newState,
    };
    try {
      final response = await NetworkManager().requestWith(
        endPoint: endPoint,
        method: httpMethod,
        headers: headers,
        params: params,
      );
      print("USER DATA $response");
      return BaseResponse.fromJson(
          response, (json) => CheckResponse.fromJson(json));
    } catch (error) {
      throw Exception('Error al traer los eventos del usuario: $error');
    }
  }
}
