import 'package:proyecto_programovil_g3/models/GoogleMaps/display_location.dart';
import 'package:proyecto_programovil_g3/models/GoogleMaps/location_response.dart';

class Place {
  final String placeId;
  final String formattedAddress;
  final Location location;
  final DisplayName displayName;

  Place({
    required this.placeId,
    required this.formattedAddress,
    required this.location,
    required this.displayName,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json['id'],
      formattedAddress: json['formattedAddress'],
      location: Location.fromJson(json['location']),
      displayName: DisplayName.fromJson(json['displayName']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placeId': placeId,
      'formattedAddress': formattedAddress,
      'location': location.toJson(),
      'displayName': displayName.toJson(),
    };
  }
}
