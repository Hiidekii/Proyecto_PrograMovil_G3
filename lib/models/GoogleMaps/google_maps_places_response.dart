import 'package:proyecto_programovil_g3/models/GoogleMaps/place_response.dart';

class GoogleMapsPlacesResponse {
  final List<Place> places;

  GoogleMapsPlacesResponse({
    required this.places,
  });

  // Factory method para crear una instancia de 'PlacesResponse' desde un mapa JSON
  factory GoogleMapsPlacesResponse.fromJson(Map<String, dynamic> json) {
    return GoogleMapsPlacesResponse(
      places: List<Place>.from(
          json['places'].map((place) => Place.fromJson(place))),
    );
  }

  // Método para convertir una instancia de 'PlacesResponse' a JSON
  Map<String, dynamic> toJson() {
    return {
      'places': places.map((place) => place.toJson()).toList(),
    };
  }
}
