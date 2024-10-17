import 'package:proyecto_programovil_g3/models/Auth/register_response.dart';
import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceCreateEvent implements WebServiceProtocol {
  @override
  EndPoint get endPoint => EndPoint.createEvent;
  @override
  HTTPMethod get httpMethod => HTTPMethod.post;

  Future<BaseResponse<RegisterResponse>> fetchData(
    String token,
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
  ) async {
    final headers = {
      'Authorization': 'Token $token',
    };
    final body = {
      "title": title,
      "description": description,
      "thumbnail":
          thumbnail, // Debe ser una URL o el nombre de la imagen que has subido
      "wsp_link": wspLink,
      "music_link": musicLink,
      "datetime": datetime
          .toIso8601String(), // Asegúrate de que 'datetime' sea un objeto DateTime
      "displayName": displayName,
      "formattedAddress": formattedAddress,
      "latitude": latitude,
      "longitude": longitude
    };

    try {
      final response = await NetworkManager().requestWith(
        endPoint: endPoint,
        method: httpMethod,
        headers: headers,
        body: body,
      );
      return BaseResponse.fromJson(
          response, (json) => RegisterResponse.fromJson(json));
    } catch (error) {
      throw Exception('Error al crear el evento: $error');
    }
  }
}
