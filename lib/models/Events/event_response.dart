// Clase que representa cada evento
import 'package:proyecto_programovil_g3/models/Events/event_location_response.dart';

class EventDataResponse {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final DateTime dateTime; // Campo DateTime
  final String wspLink;
  final String musicLink;
  final bool isPublic;
  final bool? isFavourite; // Campo opcional
  final EventLocationResponse location;

  EventDataResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.dateTime,
    required this.wspLink,
    required this.musicLink,
    required this.isPublic,
    this.isFavourite, // Campo opcional
    required this.location,
  });

  // Método para decodificar el JSON
  factory EventDataResponse.fromJson(Map<String, dynamic> json) {
    return EventDataResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      dateTime: DateTime.parse(json['dateTime']), // Decodificación de DateTime
      wspLink: json['wsp_link'],
      musicLink: json['music_link'],
      isPublic: json['isPublic'],
      isFavourite: json['isFavourite'], // Puede ser null
      location: EventLocationResponse.fromJson(json['location']),
    );
  }
}
