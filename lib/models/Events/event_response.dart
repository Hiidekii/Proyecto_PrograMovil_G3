import 'package:flutter/foundation.dart';
import 'package:proyecto_programovil_g3/extensions/date_extensions.dart';
import 'package:proyecto_programovil_g3/models/Events/event_category_response.dart';
import 'package:proyecto_programovil_g3/models/Events/event_location_response.dart';
import 'package:proyecto_programovil_g3/models/User/user_response.dart';

class EventDataResponse {
  final String? error;
  final String? message;
  final int id;
  final String title;
  final String description;
  final bool? isAdmin;
  final String thumbnail;
  final DateTime dateTime;
  final String wspLink;
  final String musicLink;
  final bool? isPublic;
  final bool? isFavourite;
  final EventLocationResponse location;
  final List<User>? members; // Hacemos members opcional
  final List<CategoryResponse> lista;

  EventDataResponse(
      {this.error,
      this.message,
      required this.id,
      required this.title,
      required this.description,
      this.isAdmin,
      required this.thumbnail,
      required this.dateTime,
      required this.wspLink,
      required this.musicLink,
      this.isPublic,
      this.isFavourite,
      required this.location,
      required this.members, // Cambiamos a opcional
      required this.lista});

  factory EventDataResponse.fromJson(Map<String, dynamic> json) {
    return EventDataResponse(
      error: json['error'],
      message: json['message'],
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isAdmin: json['isAdmin'],
      thumbnail: json['thumbnail'],
      dateTime: DateTime.parse(json['dateTime']).toLocalTime(),
      wspLink: json['wsp_link'],
      musicLink: json['music_link'],
      isPublic: json['isPublic'],
      isFavourite: json['isFavourite'],
      location: EventLocationResponse.fromJson(json['location']),
      members: ((json['members'] as List<dynamic>?) ?? [])
          .map((user) => User.fromJson(user))
          .toList(), // Manejo de opcional'
      lista: ((json['list'] as List<dynamic>?) ?? [])
          .map((category) => CategoryResponse.fromJson(category))
          .toList(),
    );
  }
}
