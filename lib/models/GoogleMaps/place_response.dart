import 'package:proyecto_programovil_g3/models/GoogleMaps/display_location.dart';
import 'package:proyecto_programovil_g3/models/GoogleMaps/location_response.dart';

class Place {
  final String formattedAddress;
  final Location location;
  final DisplayName displayName;

  Place({
    required this.formattedAddress,
    required this.location,
    required this.displayName,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      formattedAddress: json['formattedAddress'],
      location: Location.fromJson(json['location']),
      displayName: DisplayName.fromJson(json['displayName']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'formattedAddress': formattedAddress,
      'location': location.toJson(),
      'displayName': displayName.toJson(),
    };
  }
}
