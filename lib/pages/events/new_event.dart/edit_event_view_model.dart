import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';
import 'package:proyecto_programovil_g3/models/GoogleMaps/place_response.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_create_event.dart';
import 'package:proyecto_programovil_g3/webServices/GoogleMaps/web_service_google_maps.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

class EditEventViewModel extends GetxController {
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
  var isEditing = false.obs;
  var eventId = 0.obs;

  final webServiceCreateEvent = WebServiceCreateEvent();

  void loadEventForEditing(EventDataResponse event) {
    isEditing.value = true;
    eventId.value = event.id;
    title.value = event.title;
    description.value = event.description;
    date.value = event.dateTime;
    time.value = TimeOfDay.fromDateTime(event.dateTime);
    chatLink.value = event.wspLink;
    playlistLink.value = event.musicLink;
    isPublic.value = event.isPublic ?? false;
    
    // Cargar ubicación
    selectedPlace.value = Place(
      placeId: event.location.placeId,
      displayName: DisplayName(text: event.location.displayName),
      formattedAddress: event.location.formattedAddress,
      location: PlaceLocation(
        latitude: event.location.latitude,
        longitude: event.location.longitude,
      ),
    );
    
    // No cargamos la imagen ya que necesitaríamos convertirla de URL a base64
    // El usuario deberá seleccionar una nueva imagen si desea cambiarla
  }

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
    if (title.value.isEmpty ||
        date.value == null ||
        time.value == null ||
        description.value.isEmpty ||
        selectedPlace.value == null ||
        chatLink.value.isEmpty) {
      setError("Todos los campos deben ser rellenados");
      return;
    }

    // Si estamos editando y no se seleccionó una nueva imagen, no validamos imageBase64
    if (!isEditing.value && imageBase64.value.isEmpty) {
      setError("Debe seleccionar una imagen");
      return;
    }

    tz.initializeTimeZones();
    final Location peru = tz.getLocation('America/Lima');
    final DateTime combinedDateTime = tz.TZDateTime(
      peru,
      date.value!.year,
      date.value!.month,
      date.value!.day,
      time.value!.hour,
      time.value!.minute,
    );

    try {
      final response = await webServiceCreateEvent.fetchData(
        title.value,
        description.value,
        imageBase64.value,
        chatLink.value,
        playlistLink.value,
        combinedDateTime,
        selectedPlace.value?.placeId ?? "",
        selectedPlace.value?.displayName.text ?? "",
        selectedPlace.value?.formattedAddress ?? "",
        selectedPlace.value?.location.latitude ?? 1.0,
        selectedPlace.value?.location.longitude ?? 1.0,
        isPublic.value,
        id: isEditing.value ? eventId.value : null,  // Enviamos el ID solo si estamos editando
      );

      if (response.success) {
        Get.snackbar(
          'Éxito',
          isEditing.value 
              ? 'El evento se ha actualizado correctamente.'
              : 'El evento se ha creado correctamente.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        clearEventForm();
        Navigator.pop(context);
      } else {
        setError(response.data.error ?? "");
      }
    } catch (e) {
      setError("Hubo un error al ${isEditing.value ? 'actualizar' : 'crear'} el evento");
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
    // Agregamos la limpieza de las nuevas propiedades
    isEditing.value = false;
    eventId.value = 0;
  }
}
