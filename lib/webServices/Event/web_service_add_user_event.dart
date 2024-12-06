import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/models/Auth/check_response.dart';
import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceAddUserEvent implements WebServiceProtocol {
  final GetStorage storage = GetStorage();

  @override
  EndPoint get endPoint => EndPoint.addUserEvent;

  @override
  HTTPMethod get httpMethod => HTTPMethod.get;

  Future<BaseResponse<CheckResponse>> fetchData(
    String identifier, // Cambiar userId por identifier
    int eventId,
  ) async {
    final token = storage.read('token') ?? "";
    final headers = {
      'Authorization': 'Token $token',
    };

    final params = {
      "identifier": identifier, // Cambiar user_id por identifier
      "id": eventId,
    };

    try {
      final response = await NetworkManager().requestWith(
        endPoint: endPoint,
        method: httpMethod,
        headers: headers,
        params: params,
      );
      return BaseResponse.fromJson(
        response,
        (json) => CheckResponse.fromJson(json),
      );
    } catch (error) {
      throw Exception('$error');
    }
  }
}
