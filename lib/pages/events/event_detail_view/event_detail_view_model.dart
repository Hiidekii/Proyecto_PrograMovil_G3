import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/models/Events/event_location_response.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';
import 'package:proyecto_programovil_g3/models/User/user_response.dart';
import 'package:proyecto_programovil_g3/pages/events/new_event.dart/new_event_view_model.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_event_detail.dart';

class EventDetailViewModel extends GetxController {
  final WebServiceEventDetail webServiceEventDetail = WebServiceEventDetail();

  var event = Rx<EventDataResponse>(EventDataResponse(
      id: 1,
      title: "Cargando...",
      description: "Cargando...",
      dateTime: DateTime.now(),
      thumbnail: "Cargando...",
      wspLink: "Adaw",
      musicLink: "adawd",
      members: [],
      location: EventLocationResponse(
          formattedAddress: "Ad",
          displayName: "Ad",
          latitude: 1.01231,
          longitude: 12.222)));
  var filteredPeople = <User>[].obs;
  TextEditingController searchController = TextEditingController();

  var selectedIndex = 0.obs;
  final int eventId;

  EventDetailViewModel(this.eventId);

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void loadRefresh() {
    loadEventDetail();
  }

  void loadEventDetail() async {
    final response = await webServiceEventDetail.fetchData(eventId);
    if (response.success) {
      print("REEMPLAZANDO");
      event.value = response.data;
      print('xd ${event.value.members}');
      filteredPeople.value = event.value.members ?? [];
      print('OJITO${filteredPeople}');
    } else {
      print("Error al cargar los detalles del evento: ${response.data}");
      filteredPeople.clear();
    }
  }

  void onSearchUsers(String query) {
    if (query.isEmpty) {
      filteredPeople.value = event.value.members ?? [];
    } else {
      filteredPeople.value = (event.value.members ?? [])
          .where((user) =>
              user.username.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void onAddPerson() {
    print("Añadir persona");
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
