import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/extensions/image_extensions.dart';
import 'package:proyecto_programovil_g3/models/GoogleMaps/place_response.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_create_event.dart';
import 'package:proyecto_programovil_g3/webServices/GoogleMaps/web_service_google_maps.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

class NewEventViewModel extends GetxController {
  // Variables observables
  RxString imageBase64 = ''.obs;
  var title = ''.obs;
  var date = Rx<DateTime?>(null);
  var time = Rx<TimeOfDay?>(null);
  var description = ''.obs;
  var selectedPlace = Rx<Place?>(null);
  var playlistLink = ''.obs;
  var chatLink = ''.obs;
  var searchText = ''.obs;
  var places = <Place>[].obs;
  var isPublic = false.obs; // Por defecto, es público

  final webServiceCreateEvent = WebServiceCreateEvent();
  final GetStorage storage = GetStorage();

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

  void setEventVisibility(bool value) {
    isPublic.value = value;
  }

  Future<void> submitEvent(BuildContext context) async {
    print(
        "${title.value.isEmpty}-${date.value}-${time.value}-${description.value.isEmpty}-${selectedPlace.value}-${imageBase64.value.isEmpty}-${playlistLink.value.isEmpty}-${chatLink.value.isEmpty}-");
    if (title.value.isEmpty ||
        date.value == null ||
        time.value == null ||
        description.value.isEmpty ||
        selectedPlace.value == null ||
        imageBase64.value.isEmpty ||
        chatLink.value.isEmpty) {
      setError("Todos los campos deben ser rellenados");
      return;
    }

    // Inicializa el paquete timezone
    tz.initializeTimeZones();

    // Obtener la zona horaria específica (por ejemplo, para Lima, Perú)
    final Location peru = tz.getLocation('America/Lima');

    // Combina la fecha y la hora en la zona horaria específica
    final DateTime combinedDateTime = tz.TZDateTime(
      peru,
      date.value!.year,
      date.value!.month,
      date.value!.day,
      time.value!.hour,
      time.value!.minute,
    );

    try {
      final token = storage.read('token') ?? "";
      String compressedBase64 = await compressBase64Image(imageBase64.value);
      print(compressedBase64);
      final response = await webServiceCreateEvent.fetchData(
        token,
        title.value,
        description.value,
        compressedBase64,
        chatLink.value,
        playlistLink.value,
        combinedDateTime,
        selectedPlace.value?.displayName.text ?? "",
        selectedPlace.value?.formattedAddress ?? "",
        selectedPlace.value?.location.latitude ?? 1.0,
        selectedPlace.value?.location.longitude ?? 1.0,
      );
      if (response.success) {
        Get.snackbar('Éxito', 'El evento se ha creado correctamente.');
        clearEventForm();
        Navigator.pop(context);
      } else {
        setError(
          response.data.error ?? "",
        );
      }
    } catch (e) {
      setError("Hubo un error al crear el evento");
      print('Error al enviar evento: ${e.toString()}');
    }
  }

  void setError(String error) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.snackbar(
      "Error",
      error,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  void clearEventForm() {
    imageBase64.value = '';
    title.value = '';
    date.value = null;
    time.value = null;
    description.value = '';
    selectedPlace.value = null;
    playlistLink.value = '';
    chatLink.value = '';
    isPublic.value = false;
  }
}
