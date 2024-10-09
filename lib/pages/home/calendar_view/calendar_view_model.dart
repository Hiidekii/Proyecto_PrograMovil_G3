import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/models/calendar_event.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewModel extends ChangeNotifier {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  final List<CalendarEvent> _events = [
    CalendarEvent(
      1,
      'Reunión de Proyectos',
      DateTime(2024, 10, 5, 9, 0),
      'Lima',
      AppColors.yellow, // Asigna el color correspondiente
    ),
    CalendarEvent(
      2,
      'Cumpleaños de Hideki',
      DateTime(2024, 10, 5, 14, 0),
      'Surco',
      AppColors.red,
    ),
    CalendarEvent(
      3,
      'Chocolatada Anual',
      DateTime(2024, 10, 5, 18, 0),
      'Barranco',
      AppColors.pink,
    ),
    CalendarEvent(
      4,
      'Conferencia de Innovación',
      DateTime(2024, 10, 5, 10, 30),
      'Miraflores',
      AppColors.blue,
    ),
    CalendarEvent(
      5,
      'Taller de Desarrollo',
      DateTime(2024, 10, 5, 11, 0),
      'San Isidro',
      AppColors.yellow,
    ),
    CalendarEvent(
      6,
      'Hackathon de Swift',
      DateTime(2024, 10, 6, 13, 30),
      'San Borja',
      AppColors.red,
    ),
    CalendarEvent(
      7,
      'Networking con Startups',
      DateTime(2024, 10, 6, 16, 0),
      'Surquillo',
      AppColors.pink,
    ),
    CalendarEvent(
      8,
      'Seminario de IA',
      DateTime(2024, 10, 6, 9, 30),
      'Pueblo Libre',
      AppColors.blue,
    ),
    CalendarEvent(
      9,
      'Lanzamiento de Producto',
      DateTime(2024, 10, 6, 10, 0),
      'La Molina',
      AppColors.yellow,
    ),
    CalendarEvent(
      10,
      'Reunión de Evaluación',
      DateTime(2024, 10, 6, 13, 0),
      'Magdalena',
      AppColors.red,
    ),
    CalendarEvent(
      11,
      'Cena de Gala',
      DateTime(2024, 10, 7, 18, 0),
      'San Miguel',
      AppColors.pink,
    ),
    CalendarEvent(
      12,
      'Fiesta de Cierre',
      DateTime(2024, 10, 7, 21, 0),
      'Callao',
      AppColors.blue,
    ),
  ];

  // Getters
  DateTime get focusedDay => _focusedDay;
  DateTime get selectedDay => _selectedDay;
  List<CalendarEvent> get events => _events;
  CalendarFormat get calendarFormat => _calendarFormat;

  // SETTERS
  void setFocusedDay(DateTime day) {
    _focusedDay = day;
    notifyListeners();
  }

  void setSelectedDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  void setCalendarFormat(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }

  //METHODS
  List<CalendarEvent> getEventsForSelectedDay() {
    List<CalendarEvent> eventsForSelectedDay =
        _events.where((event) => isSameDay(event.date, _selectedDay)).toList();

    eventsForSelectedDay.sort((a, b) => a.date.compareTo(b.date));

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
}
