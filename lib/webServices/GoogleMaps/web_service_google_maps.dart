import 'dart:convert'; // Para decodificar la respuesta JSON
import 'package:http/http.dart' as http;
import 'package:proyecto_programovil_g3/models/GoogleMaps/google_maps_places_response.dart';

class GoogleMapsService {
  final String endPoint = 'https://places.googleapis.com/v1/places:searchText';
  final String apiKey = "AIzaSyC8NzJnWoESPvjfh8e4lxknHyJjCIqgGPQ";

  GoogleMapsService();

  Future<GoogleMapsPlacesResponse> fetchPlaces(String query) async {
    final body = json.encode({
      // Convierte el Map a JSON
      'textQuery': query,
    });

    final headers = {
      "Content-Type": 'application/json',
      "X-Goog-Api-Key": apiKey,
      "X-Goog-FieldMask":
          "places.displayName,places.formattedAddress,places.location"
    };

    final Uri url = Uri.parse(endPoint);

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Parseamos la respuesta JSON al modelo GoogleMapsPlacesResponse
        final jsonResponse = json.decode(response.body);
        return GoogleMapsPlacesResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Error en la petición: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception(
          'Error al realizar la petición a Google Maps: $error con $query');
    }
  }
}
