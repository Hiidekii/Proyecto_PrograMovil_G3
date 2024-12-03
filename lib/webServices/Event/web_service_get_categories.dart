import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/models/Events/event_item_types_list_response.dart';
import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceGetCategories implements WebServiceProtocol {
  final GetStorage storage = GetStorage();
  @override
  EndPoint get endPoint => EndPoint.eventItemCategories;
  @override
  HTTPMethod get httpMethod => HTTPMethod.get;

  Future<BaseResponse<EventItemTypesListResponse>> fetchData() async {
    final token = storage.read('token') ?? "";
    final headers = {
      'Authorization': 'Token $token',
    };
    try {
      final response = await NetworkManager().requestWith(
          endPoint: endPoint, method: httpMethod, headers: headers);
      return BaseResponse.fromJson(
          response, (json) => EventItemTypesListResponse.fromJson(json));
    } catch (error) {
      throw Exception(
          'Error al traer el categorias de los tipos de evento: $error');
    }
  }
}
