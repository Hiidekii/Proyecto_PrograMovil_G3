import 'dart:convert'; // Para decodificar la respuesta JSON
import 'package:http/http.dart' as http;
import 'package:proyecto_programovil_g3/models/GoogleMaps/google_maps_places_response.dart';

class GoogleMapsService {
  final String endPoint = 'https://places.googleapis.com/v1/places:searchText';
  final String apiKey = "AIzaSyC8NzJnWoESPvjfh8e4lxknHyJjCIqgGPQ";

  GoogleMapsService();

  Future<GoogleMapsPlacesResponse> fetchPlaces(String query) async {
    print('Searching for places with query: $query');  // Debug log
    
    final body = json.encode({
      'textQuery': query,
    });

    final headers = {
      "Content-Type": 'application/json',
      "X-Goog-Api-Key": apiKey,
      "X-Goog-FieldMask":
          "places.id,places.displayName,places.formattedAddress,places.location"
    };

    final Uri url = Uri.parse(endPoint);

    try {
      final response = await http.post(url, headers: headers, body: body);
      print('Response status: ${response.statusCode}');  // Debug log
      print('Response body: ${response.body}');  // Debug log

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return GoogleMapsPlacesResponse.fromJson(jsonResponse);
      } else {
        print('Error response: ${response.body}');  // Debug log
        throw Exception('Error en la petición: ${response.statusCode}');
      }
    } catch (error) {
      print('Exception caught: $error');  // Debug log
      throw Exception('Error al realizar la petición a Google Maps: $error');
    }
  }
}
