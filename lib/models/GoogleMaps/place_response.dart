// place.dart
class Place {
  final String id;  // Cambio de placeId a id
  final DisplayName displayName;
  final String formattedAddress;
  final Location location;

  Place({
    required this.id,
    required this.displayName,
    required this.formattedAddress,
    required this.location,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],  // La API devuelve 'id', no 'placeId'
      displayName: DisplayName.fromJson(json['displayName']),
      formattedAddress: json['formattedAddress'],
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName.toJson(),
      'formattedAddress': formattedAddress,
      'location': location.toJson(),
    };
  }
}

// display_name.dart
class DisplayName {
  final String text;
  final String? languageCode;

  DisplayName({
    required this.text,
    this.languageCode,
  });

  factory DisplayName.fromJson(Map<String, dynamic> json) {
    return DisplayName(
      text: json['text'],
      languageCode: json['languageCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      if (languageCode != null) 'languageCode': languageCode,
    };
  }
}

// location.dart
class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

