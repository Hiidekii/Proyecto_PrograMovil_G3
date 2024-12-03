import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/models/Auth/check_response.dart';
import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceEventItem implements WebServiceProtocol {
  final GetStorage storage = GetStorage();
  @override
  EndPoint get endPoint => EndPoint.setEventItem;
  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  Future<BaseResponse<CheckResponse>> createItem(
    int eventId,
    int itemTypeId,
    String itemName,
    double totalAmount,
  ) async {
    final token = storage.read('token') ?? "";
    final headers = {
      'Authorization': 'Token $token',
    };
    final body = {
      "event_id": eventId,
      "item_type_id": itemTypeId,
      "item_name": itemName,
      "total_amount": totalAmount,
    };
    try {
      final response = await NetworkManager().requestWith(
          endPoint: endPoint, method: httpMethod, headers: headers, body: body);
      return BaseResponse.fromJson(
          response, (json) => CheckResponse.fromJson(json));
    } catch (error) {
      throw Exception('Error al crear item de evento: $error');
    }
  }

  Future<BaseResponse<CheckResponse>> editItem(
    int eventId,
    int itemId,
    int itemTypeId,
    String itemName,
    int totalAmount,
  ) async {
    final token = storage.read('token') ?? "";
    final headers = {
      'Authorization': 'Token $token',
    };
    final body = {
      "event_id": eventId,
      "item_id": itemId,
      "item_type_id": itemTypeId,
      "item_name": itemName,
      "total_amount": totalAmount,
    };
    try {
      final response = await NetworkManager().requestWith(
          endPoint: endPoint, method: httpMethod, headers: headers, body: body);
      return BaseResponse.fromJson(
          response, (json) => CheckResponse.fromJson(json));
    } catch (error) {
      throw Exception('Error al editar item de evento: $error');
    }
  }
}
