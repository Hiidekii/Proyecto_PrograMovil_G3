import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/models/Events/event_list_response.dart';
import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServicePublicEvents implements WebServiceProtocol {
  final GetStorage storage = GetStorage();
  @override
  EndPoint get endPoint => EndPoint.publicEvents;
  @override
  HTTPMethod get httpMethod => HTTPMethod.get;

  Future<BaseResponse<EventListResponse>> fetchData() async {
    final token = storage.read('token') ?? "";
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
      return BaseResponse.fromJson(
          response, (json) => EventListResponse.fromJson(json));
    } catch (error) {
      throw Exception('Error al traer los eventos del usuario: $error');
    }
  }
}
