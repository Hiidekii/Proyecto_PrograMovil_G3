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
        print("\nEvents loaded in ViewModel:");
        print("Total events received: ${response.data.length}");
        
        userEvents.value = response.data;
        print("userEvents length after assignment: ${userEvents.length}");
        
        filterEvents();
      } else {
        hasError.value = true;
        errorMessage.value = response.data.toString();
      }
    } catch (e) {
      print("Error in loadEvents: $e");
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void filterEvents() {
    print("\nFiltering events");
    print("Total events to filter: ${userEvents.length}");
    
    // Filtrar eventos donde el usuario es admin
    final adminList = userEvents.where((event) {
      print("Event '${event.title}' isAdmin: ${event.isAdmin}");
      return event.isAdmin ?? false;
    }).toList();
    print("Admin events found: ${adminList.length}");
    adminEvents.value = adminList;
    
    // Filtrar eventos favoritos
    final favoriteList = userEvents.where((event) {
      print("Event '${event.title}' isFavorite: ${event.isFavourite}");
      return event.isFavourite ?? false;
    }).toList();
    print("Favorite events found: ${favoriteList.length}");
    favoriteEvents.value = favoriteList;
    
    // Filtrar eventos donde el usuario es invitado
    final guestList = userEvents.where((event) {
      print("Event '${event.title}' checking guest (not admin): ${!(event.isAdmin ?? false)}");
      return !(event.isAdmin ?? false);
    }).toList();
    print("Guest events found: ${guestList.length}");
    guestEvents.value = guestList;
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
