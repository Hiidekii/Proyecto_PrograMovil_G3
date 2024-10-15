import 'package:proyecto_programovil_g3/models/Events/event_response.dart';

class EventListResponse {
  final List<EventDataResponse> events;

  EventListResponse({
    required this.events,
  });

  // Método para decodificar el JSON
  factory EventListResponse.fromJson(List<dynamic> json) {
    print("DESDE LIST  ${json}");
    return EventListResponse(
      events: json
          .map((event) =>
              EventDataResponse.fromJson(event as Map<String, dynamic>))
          .toList(),
    );
  }
}
