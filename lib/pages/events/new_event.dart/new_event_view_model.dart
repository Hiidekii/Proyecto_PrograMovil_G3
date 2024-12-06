import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';
import 'package:proyecto_programovil_g3/models/GoogleMaps/place_response.dart' as maps;
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
  var selectedPlace = Rx<maps.Place?>(null);
  var playlistLink = ''.obs;
  var chatLink = ''.obs;
  var searchText = ''.obs;
  var places = <maps.Place>[].obs;
  var isPublic = false.obs; // Por defecto, es público
  var isEditing = false.obs;
  var eventId = 0.obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final chatLinkController = TextEditingController();
  final playlistLinkController = TextEditingController();

  final webServiceCreateEvent = WebServiceCreateEvent();

  @override
  void onInit() {
    super.onInit();
    // Vinculamos los controladores con las variables reactivas
    titleController.addListener(() => title.value = titleController.text);
    descriptionController.addListener(() => description.value = descriptionController.text);
    chatLinkController.addListener(() => chatLink.value = chatLinkController.text);
    playlistLinkController.addListener(() => playlistLink.value = playlistLinkController.text);
  }

  void loadEventForEditing(EventDataResponse event) {
    isEditing.value = true;
    eventId.value = event.id;
    
    // Actualizamos los controladores
    titleController.text = event.title;
    descriptionController.text = event.description;
    chatLinkController.text = event.wspLink;
    playlistLinkController.text = event.musicLink;
    
    // Resto de campos...
    date.value = event.dateTime;
    time.value = TimeOfDay.fromDateTime(event.dateTime);
    isPublic.value = event.isPublic ?? false;
    
    selectedPlace.value = maps.Place(
      id: event.location.placeId,
      displayName: maps.DisplayName(
        text: event.location.displayName,
        languageCode: null  // Agregamos el languageCode como null
      ),
      formattedAddress: event.location.formattedAddress,
      location: maps.Location(  // Cambiamos PlaceLocation por Location
        latitude: event.location.latitude,
        longitude: event.location.longitude,
      ),
    );
  }

  void searchLocations(String query) async {
    print('Searching locations with query: $query');  // Debug log
    if (query.isNotEmpty) {
      try {
        final webServiceGoogleMaps = GoogleMapsService();
        final response = await webServiceGoogleMaps.fetchPlaces(query);
        print('Places found: ${response.places.length}');  // Debug log
        places.assignAll(response.places);
      } catch (e) {
        print('Error searching locations: $e');  // Debug log
        setError('Error al buscar lugares: $e');
      }
    } else {
      places.clear();
    }
  }

  void setEventVisibility(bool value) {
    isPublic.value = value;
  }

  Future<void> submitEvent(BuildContext context) async {
    print("Validando campos...");
    print("Title controller: ${titleController.text}");
    print("Description controller: ${descriptionController.text}");
    print("Chat link controller: ${chatLinkController.text}");
    print("Playlist link controller: ${playlistLinkController.text}");

    if (titleController.text.isEmpty ||
        date.value == null ||
        time.value == null ||
        descriptionController.text.isEmpty ||
        selectedPlace.value == null ||
        chatLinkController.text.isEmpty) {
      setError("Todos los campos deben ser rellenados");
      return;
    }

    // Si estamos editando y no se seleccionó una nueva imagen, no validamos imageBase64
    if (!isEditing.value && imageBase64.value.isEmpty) {
      setError("Debe seleccionar una imagen");
      return;
    }

    tz.initializeTimeZones();
    final tz.Location peru = tz.getLocation('America/Lima');
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
        titleController.text,
        descriptionController.text,
        imageBase64.value,
        chatLinkController.text,
        playlistLinkController.text,
        combinedDateTime,
        selectedPlace.value?.id?? "",
        selectedPlace.value?.displayName.text ?? "",
        selectedPlace.value?.formattedAddress ?? "",
        selectedPlace.value?.location.latitude ?? 1.0,
        selectedPlace.value?.location.longitude ?? 1.0,
        isPublic.value,
        id: isEditing.value ? eventId.value : null,
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
    // Limpiamos los controladores
    titleController.clear();
    descriptionController.clear();
    chatLinkController.clear();
    playlistLinkController.clear();
    
    // Resto de campos...
    imageBase64.value = '';
    title.value = '';
    description.value = '';
    date.value = null;
    time.value = null;
    selectedPlace.value = null;
    playlistLink.value = '';
    chatLink.value = '';
    isPublic.value = false;
    isEditing.value = false;
    eventId.value = 0;
  }

  @override
  void onClose() {
    // Limpiamos los controladores al cerrar
    titleController.dispose();
    descriptionController.dispose();
    chatLinkController.dispose();
    playlistLinkController.dispose();
    super.onClose();
  }
}
