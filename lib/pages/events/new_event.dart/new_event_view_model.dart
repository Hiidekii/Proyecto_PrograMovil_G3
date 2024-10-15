import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/models/GoogleMaps/display_location.dart';
import 'package:proyecto_programovil_g3/models/GoogleMaps/location_response.dart';
import 'package:proyecto_programovil_g3/models/GoogleMaps/place_response.dart';
import 'package:proyecto_programovil_g3/webServices/GoogleMaps/web_service_google_maps.dart';

class NewEventViewModel extends GetxController {
  // Variables observables
  var title = ''.obs;
  var date = Rx<DateTime?>(null);
  var time = Rx<TimeOfDay?>(null);
  var description = ''.obs;
  var selectedPlace = Rx<Place?>(null);
  var playlistLink = ''.obs;
  var chatLink = ''.obs;
  var searchText = ''.obs;
  var places = <Place>[].obs;

  void searchLocations(String query) async {
    if (query.isNotEmpty) {
      try {
        final webServiceGoogleMaps = GoogleMapsService();
        final response = await webServiceGoogleMaps.fetchPlaces(query);
        places.assignAll(response.places);
      } catch (e) {
        print('Error al buscar lugares: ${e.toString()}');
      }
    } else {
      places.value = [];
    }
  }
}
