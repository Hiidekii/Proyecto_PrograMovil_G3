import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/components/q_sale_error_manager.dart';
import 'package:proyecto_programovil_g3/models/Events/event_location_response.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';
import 'package:proyecto_programovil_g3/models/User/user_response.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_add_user_event_item.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_event_detail.dart';

class EventDetailViewModel extends GetxController {
  final WebServiceEventDetail webServiceEventDetail = WebServiceEventDetail();
  final WebServiceAddUserEventItem webServiceUserItem =
      WebServiceAddUserEventItem();
  var event = Rx<EventDataResponse>(
    EventDataResponse(
      id: 1,
      title: "Cargando...",
      description: "Cargando...",
      dateTime: DateTime.now(),
      thumbnail: "Cargando...",
      wspLink: "Adaw",
      musicLink: "adawd",
      members: [],
      location: EventLocationResponse(
          placeId: "s",
          formattedAddress: "Ad",
          displayName: "Ad",
          latitude: 1.01231,
          longitude: 12.222),
      lista: [],
    ),
  );

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

  void addUserItem(int itemID, double amount) async {
    try {
      if (amount <= 0) {
        throw Exception("La cantidad debe ser mayor que cero.");
      }
      final response = await webServiceUserItem.fetchData(itemID, amount);
      if (response.success) {
        loadEventDetail();
      } else {
        print(response.data);
      }
    } catch (error) {
      ErrorSnackbar().showError(error.toString());
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

  String getCurrentUserRole() {
    final currentUser = event.value.members?.firstWhere(
      (member) => member.username.contains("(Tú)"),
      orElse: () => User(
        username: "",
        email: "",
        thumbnail: "",
        role: "",
        confirmation: ""
      )
    );
    return currentUser?.role ?? '';
  }

  String getCurrentUserConfirmation() {
    final currentUser = event.value.members?.firstWhere(
      (member) => member.username.contains("(Tú)"),
      orElse: () => User(
        username: "",
        email: "",
        thumbnail: "",
        role: "",
        confirmation: ""
      )
    );
    return currentUser?.confirmation ?? '';
  }

  Future<void> updateAttendance(String status) async {
    try {
      // Aquí deberás implementar el servicio web para actualizar la asistencia
      // final response = await webServiceUpdateAttendance.fetchData(eventId, status);
      // if (response.success) {
      //   loadEventDetail();
      // }
      loadEventDetail(); // Temporalmente solo recargamos los datos
    } catch (error) {
      ErrorSnackbar().showError(error.toString());
    }
  }
}
