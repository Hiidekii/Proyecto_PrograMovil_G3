import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';
import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceEventDetail implements WebServiceProtocol {
  final GetStorage storage = GetStorage();
  @override
  EndPoint get endPoint => EndPoint.eventDetail;
  @override
  HTTPMethod get httpMethod => HTTPMethod.get;

  Future<BaseResponse<EventDataResponse>> fetchData(int id) async {
    final token = storage.read('token') ?? "";
    final headers = {
      'Authorization': 'Token $token',
    };
    final params = {
      'id': id,
    };
    try {
      final response = await NetworkManager().requestWith(
        endPoint: endPoint,
        method: httpMethod,
        headers: headers,
        params: params,
      );
      return BaseResponse.fromJson(
          response, (json) => EventDataResponse.fromJson(json));
    } catch (error) {
      throw Exception('Error al traer el detalle del evento: $error');
    }
  }
}
