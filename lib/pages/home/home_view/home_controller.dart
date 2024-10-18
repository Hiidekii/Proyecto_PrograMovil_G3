import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_public_events.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_set_favourite.dart';
import 'package:proyecto_programovil_g3/webServices/User/web_service_user_events.dart';

class HomeController extends GetxController {
  final RxList<EventDataResponse> userEvents = <EventDataResponse>[].obs;
  final RxList<EventDataResponse> publicEvents = <EventDataResponse>[].obs;
  final webServiceUserEvents = WebServiceUserEvents();
  final webServicePublicEvents = WebServicePublicEvents();
  final webServiceSetFavourite = WebServiceSetFavourite();
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadUserEvents();
    loadPublicEvents();
  }

  void loadUserEvents() async {
    final token = storage.read('token') ?? "";
    final response = await webServiceUserEvents.fetchData(token);
    userEvents.value = response.data.events;
  }

  void loadPublicEvents() async {
    final token = storage.read('token') ?? "";
    final response = await webServicePublicEvents.fetchData(token);
    publicEvents.value = response.data.events;
  }

  void setFavouriteState(int eventId, bool newState) async {
    final token = storage.read('token') ?? "";
    final response =
        await webServiceSetFavourite.fetchData(token, eventId, !newState);
    if (response.success) {
      refreshEvents();
    }
    print(eventId);
  }

  void refreshEvents() async {
    loadUserEvents();
    loadPublicEvents();
  }

  List<EventDataResponse> getFavourites() {
    return userEvents.where((event) {
      return event.isFavourite ?? false;
    }).toList();
  }
}
