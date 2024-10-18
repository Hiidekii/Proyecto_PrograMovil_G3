import 'dart:ffi';

import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/models/Auth/check_response.dart';
import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceCreateEvent implements WebServiceProtocol {
  final GetStorage storage = GetStorage();
  @override
  EndPoint get endPoint => EndPoint.createEvent;
  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  Future<BaseResponse<CheckResponse>> fetchData(
    String title,
    String description,
    String thumbnail,
    String wspLink,
    String musicLink,
    DateTime datetime,
    String displayName,
    String formattedAddress,
    double latitude,
    double longitude,
    bool isPublic,
  ) async {
    final token = storage.read('token') ?? "";
    final headers = {
      'Authorization': 'Token $token',
    };
    final body = {
      "title": title,
      "description": description,
      "thumbnail": thumbnail,
      "wsp_link": wspLink,
      "music_link": musicLink,
      "datetime": datetime.toIso8601String(),
      "displayName": displayName,
      "formattedAddress": formattedAddress,
      "latitude": latitude,
      "longitude": longitude,
      "isPublic": isPublic,
    };

    try {
      final response = await NetworkManager().requestWith(
        endPoint: endPoint,
        method: httpMethod,
        headers: headers,
        body: body,
      );
      return BaseResponse.fromJson(
          response, (json) => CheckResponse.fromJson(json));
    } catch (error) {
      throw Exception('Error al crear el evento: $error');
    }
  }
}
