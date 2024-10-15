import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class Event {
  int id;
  String title;
  String description;
  String thumbnail;
  String wspLink;
  String musicLink;
  int categoryId;
  DateTime datetime;
  int locationId;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.wspLink,
    required this.musicLink,
    required this.categoryId,
    required this.datetime,
    required this.locationId,
  });

  // fromMap method to create an Event object from a map
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      thumbnail: map['thumbnail'],
      wspLink: map['wspLink'],
      musicLink: map['musicLink'],
      categoryId: map['categoryId'],
      datetime: DateTime.parse(map['datetime']),
      locationId: map['locationId'],
    );
  }

  // toJson method to convert the Event object to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'wspLink': wspLink,
      'musicLink': musicLink,
      'categoryId': categoryId,
      'datetime': datetime.toIso8601String(),
      'locationId': locationId,
    };
  }

  // toString method for a readable format of the Event object
  @override
  String toString() {
    return 'Event{id: $id, title: $title, description: $description, datetime: $datetime, locationId: $locationId}';
  }
}
