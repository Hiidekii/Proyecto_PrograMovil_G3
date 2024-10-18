class EventLocationResponse {
  final String formattedAddress;
  final String displayName;
  final double latitude;
  final double longitude;

  EventLocationResponse({
    required this.formattedAddress,
    required this.displayName,
    required this.latitude,
    required this.longitude,
  });

  // Método para decodificar el JSON
  factory EventLocationResponse.fromJson(Map<String, dynamic> json) {
    return EventLocationResponse(
      formattedAddress: json['formattedAddress'],
      displayName: json['displayName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
