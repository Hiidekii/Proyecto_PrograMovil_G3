import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/components/q_sale_error_manager.dart';
import 'package:proyecto_programovil_g3/models/Events/event_category_response.dart';
import 'package:proyecto_programovil_g3/models/Events/event_location_response.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';
import 'package:proyecto_programovil_g3/models/User/user_response.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_add_user_event_item.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_delete_event_item.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_delete_user_event.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_event_detail.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_event_item.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_get_categories.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_set_user_event_status.dart';

class EventDetailViewModel extends GetxController {
  final WebServiceEventDetail webServiceEventDetail = WebServiceEventDetail();
  final WebServiceAddUserEventItem webServiceUserItem =
      WebServiceAddUserEventItem();
  final WebServiceSetUserEventStatus webServiceSetUserEventStatus =
      WebServiceSetUserEventStatus();

  final WebServiceGetCategories webServiceItemCategories =
      WebServiceGetCategories();
  final WebServiceEventItem webServiceEventItem = WebServiceEventItem();

  final WebServiceDeleteEventItem webServiceDeleteEventItem =
      WebServiceDeleteEventItem();
  final WebServiceDeleteUserEvent webServiceDeleteUserEvent =
      WebServiceDeleteUserEvent();
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
  var categories = RxList<CategoryResponse>();
  var selectedItemCategory = Rx<CategoryResponse>(CategoryResponse(
      id: 1, type: EventCategoryType.jama.name, floatable: false));
  void selectCategory(CategoryResponse category) {
    selectedItemCategory.value = category;
  }

  var filteredPeople = <User>[].obs;

  TextEditingController searchController = TextEditingController();

  var selectedIndex = 0.obs;
  final int eventId;
  var isAddItemModalOpen = false.obs;
  var isEditedModeActivated = false.obs;

  EventDetailViewModel(this.eventId);

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void toggleItemModal() {
    isAddItemModalOpen.value = !isAddItemModalOpen.value;
  }

  void toggleEditMode() {
    isEditedModeActivated.value = !isEditedModeActivated.value;
  }

  void getCategories() async {
    final response = await webServiceItemCategories.fetchData();
    if (response.success) {
      categories.value = response.data.categories;
    }
  }

  void createEventItem(String newName, double newAmount) async {
    final _ = await webServiceEventItem.createItem(
      eventId,
      selectedItemCategory.value.id,
      newName,
      newAmount,
    );
    toggleItemModal();
    loadRefresh();
  }

  void loadRefresh() {
    loadEventDetail();
  }

  void loadEventDetail() async {
    final response = await webServiceEventDetail.fetchData(eventId);
    if (response.success) {
      event.value = response.data;
    } else {
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
        SnackbaManager().showError(response.data.error);
      }
    } catch (error) {
      SnackbaManager().showError(error.toString());
    }
  }

  void deleteEventItem(int ItemID) async {
    try {
      final response = await webServiceDeleteEventItem.fetchData(ItemID);
      if (response.success) {
        loadEventDetail();
        SnackbaManager().ShowSuccess("Item eliminado correctamente");
      } else {
        SnackbaManager().showError(response.data.error);
      }
    } catch (error) {
      SnackbaManager().showError(error.toString());
    }
  }

  void deleteUserFromEvent(String userId) async {
    try {
      final response = await webServiceDeleteUserEvent.fetchData(
        userId,
        eventId,
      );
      if (response.success) {
        loadEventDetail();
        SnackbaManager().ShowSuccess("Usuario eliminado correctamente");
      } else {
        SnackbaManager().showError(response.data.error);
      }
    } catch (error) {
      SnackbaManager().showError(error.toString());
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  String getCurrentUserConfirmation() {
    final currentUser = event.value.members?.firstWhere(
        (member) => member.username.contains("(Tú)"),
        orElse: () => User(
            id: "",
            username: "",
            email: "",
            thumbnail: "",
            role: "",
            confirmation: ""));
    return currentUser?.confirmation ?? '';
  }

  void updateAttendance(int status) async {
    try {
      final response =
          await webServiceSetUserEventStatus.fetchData(eventId, status);
      if (response.success) {
        loadEventDetail();
      }
    } catch (error) {
      SnackbaManager().showError(error.toString());
    }
  }
}
