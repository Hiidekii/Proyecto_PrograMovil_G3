import 'package:proyecto_programovil_g3/models/Events/event_list_response.dart';
import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServicePublicEvents implements WebServiceProtocol {
  @override
  EndPoint get endPoint => EndPoint.userEvents;
  @override
  HTTPMethod get httpMethod => HTTPMethod.get;

  Future<BaseResponse<EventListResponse>> fetchData(String token) async {
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
