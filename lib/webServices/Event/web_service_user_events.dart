import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';
import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceUserEvents implements WebServiceProtocol {
  final GetStorage storage = GetStorage();
  
  @override
  EndPoint get endPoint => EndPoint.userEvents;
  
  @override
  HTTPMethod get httpMethod => HTTPMethod.get;

  Future<BaseResponse<List<EventDataResponse>>> fetchData() async {
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

      print("Raw response from API: $response");
      
      return BaseResponse<List<EventDataResponse>>.fromJson(
        response,
        (json) {
          final List<dynamic> eventsList = json as List<dynamic>;
          print("Processing ${eventsList.length} events");
          
          return eventsList.map((item) {
            print("Processing item: $item");
            final event = EventDataResponse.fromJson(item);
            print("Parsed event: ${event.title}, isAdmin: ${event.isAdmin}");
            return event;
          }).toList();
        },
      );
    } catch (error) {
      print("Error in WebServiceUserEvents: $error");
      throw Exception('$error');
    }
  }
}
