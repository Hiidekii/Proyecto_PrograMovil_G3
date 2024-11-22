import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/models/Auth/check_response.dart';
import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceSetUserEventStatus implements WebServiceProtocol {
  final GetStorage storage = GetStorage();
  @override
  EndPoint get endPoint => EndPoint.setUserEventStatus;
  @override
  HTTPMethod get httpMethod => HTTPMethod.get;

  Future<BaseResponse<CheckResponse>> fetchData(
      int eventID, int statusId) async {
    final token = storage.read('token') ?? "";
    final headers = {
      'Authorization': 'Token $token',
    };
    final params = {
      'id': eventID,
      'status_id': statusId,
    };
    try {
      final response = await NetworkManager().requestWith(
        endPoint: endPoint,
        method: httpMethod,
        headers: headers,
        params: params,
      );
      print("Confirmación cambiada con éxito: $response");
      return BaseResponse.fromJson(
          response, (json) => CheckResponse.fromJson(json));
    } catch (error) {
      throw Exception('Error al cambiar el estado de confirmacion del evento: $error');
    }
  }
}