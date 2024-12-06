import 'package:proyecto_programovil_g3/models/GoogleMaps/display_location.dart';
import 'package:proyecto_programovil_g3/models/GoogleMaps/location_response.dart';

class DisplayName {
  final String text;

  DisplayName({required this.text});

  factory DisplayName.fromJson(Map<String, dynamic> json) {
    return DisplayName(text: json['text']);
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}

class PlaceLocation {
  final double latitude;
  final double longitude;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
  });

  factory PlaceLocation.fromJson(Map<String, dynamic> json) {
    return PlaceLocation(
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class Place {
  final String placeId;
  final DisplayName displayName;
  final String formattedAddress;
  final PlaceLocation location;

  Place({
    required this.placeId,
    required this.displayName,
    required this.formattedAddress,
    required this.location,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json['placeId'],
      displayName: DisplayName.fromJson(json['displayName']),
      formattedAddress: json['formattedAddress'],
      location: PlaceLocation.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placeId': placeId,
      'displayName': displayName.toJson(),
      'formattedAddress': formattedAddress,
      'location': location.toJson(),
    };
  }
}

class GoogleMapsPlacesResponse {
  final List<Place> places;

  GoogleMapsPlacesResponse({
    required this.places,
  });

  factory GoogleMapsPlacesResponse.fromJson(Map<String, dynamic> json) {
    return GoogleMapsPlacesResponse(
      places: List<Place>.from(
          json['places'].map((place) => Place.fromJson(place))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'places': places.map((place) => place.toJson()).toList(),
    };
  }
}

