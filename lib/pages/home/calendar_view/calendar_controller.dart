import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';
import 'package:proyecto_programovil_g3/webServices/User/web_service_user_events.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;
  var calendarFormat = CalendarFormat.week.obs;

  final RxList<EventDataResponse> userEvents = <EventDataResponse>[].obs;
  final webServiceUserEvents = WebServiceUserEvents();
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadUserEvents();
  }

  void loadUserEvents() async {
    final token = storage.read('token') ?? "";
    final response = await webServiceUserEvents.fetchData(token);
    userEvents.value = response.data.events;
    print("SONDANDANWDOAWDAWDAWDAWDAWD${response.data}");
  }

  // Métodos
  List<EventDataResponse> getEventsForSelectedDay() {
    List<EventDataResponse> eventsForSelectedDay = userEvents
        .where((event) => isSameDay(event.dateTime, selectedDay.value))
        .toList();
    eventsForSelectedDay.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return eventsForSelectedDay;
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void dismissView(BuildContext context) {
    Navigator.of(context).pop();
  }

  void setFocusedDay(DateTime day) {
    focusedDay.value = day;
  }

  void setSelectedDay(DateTime day) {
    selectedDay.value = day;
  }

  void setCalendarFormat(CalendarFormat format) {
    calendarFormat.value = format;
  }
}
