import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_user_events.dart';

class EventsPageViewModel extends GetxController {
  final WebServiceUserEvents webServiceUserEvents = WebServiceUserEvents();

  var userEvents = <EventDataResponse>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;

  // Filtros de eventos
  var adminEvents = <EventDataResponse>[].obs;
  var favoriteEvents = <EventDataResponse>[].obs;
  var guestEvents = <EventDataResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadEvents();
  }

  Future<void> loadEvents() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final response = await webServiceUserEvents.fetchData();

      if (response.success) {
        userEvents.value = response.data;
        filterEvents();
      } else {
        hasError.value = true;
        errorMessage.value = response.data.toString();
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void filterEvents() {
    // Filtrar eventos donde el usuario es admin
    adminEvents.value =
        userEvents.where((event) => event.isAdmin ?? false).toList();

    // Filtrar eventos favoritos
    favoriteEvents.value =
        userEvents.where((event) => event.isFavourite ?? false).toList();

    // Filtrar eventos donde el usuario es invitado
    guestEvents.value =
        userEvents.where((event) => !(event.isAdmin ?? false)).toList();
  }

  Future<void> refreshEvents() async {
    await loadEvents();
  }

  void navigateToEventDetail(int eventId) {
    // Implementar navegación al detalle del evento
    Get.toNamed('/event-detail/$eventId');
  }

  void navigateToNewEvent() {
    // Implementar navegación a crear nuevo evento
    Get.toNamed('/new-event');
  }
}
