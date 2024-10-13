import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';

import '../calendar_view/models/calendar_event.dart';

class HomeViewModel extends ChangeNotifier {
  final List<CalendarEvent> _events = [
    CalendarEvent(
      1,
      'Reunión de Proyectos',
      DateTime(2024, 11, 5, 9, 0),
      'Lima',
      AppColors.yellow, // Asigna el color correspondiente
    ),
    CalendarEvent(
      2,
      'Cumpleaños de Hideki',
      DateTime(2024, 11, 5, 14, 0),
      'Surco',
      AppColors.red,
    ),
    CalendarEvent(
      3,
      'Chocolatada Anual',
      DateTime(2024, 11, 5, 18, 0),
      'Barranco',
      AppColors.pink,
    ),
    CalendarEvent(
      4,
      'Conferencia de Innovación',
      DateTime(2024, 11, 5, 10, 30),
      'Miraflores',
      AppColors.blue,
    ),
    CalendarEvent(
      5,
      'Taller de Desarrollo',
      DateTime(2024, 11, 5, 11, 0),
      'San Isidro',
      AppColors.yellow,
    ),
    CalendarEvent(
      6,
      'Hackathon de Swift',
      DateTime(2024, 11, 6, 13, 30),
      'San Borja',
      AppColors.red,
    ),
    CalendarEvent(7, 'Networking con Startups', DateTime(2024, 11, 6, 16, 0),
        'Surquillo', AppColors.pink,
        isFavorite: true),
    CalendarEvent(
      8,
      'Seminario de IA',
      DateTime(2024, 11, 6, 9, 30),
      'Pueblo Libre',
      AppColors.blue,
      isFavorite: true,
      isPublic: true,
    ),
    CalendarEvent(
      9,
      'Lanzamiento de Producto',
      DateTime(2024, 12, 6, 10, 0),
      'La Molina',
      AppColors.yellow,
      isPublic: true,
    ),
    CalendarEvent(10, 'Reunión de Evaluación', DateTime(2024, 10, 6, 13, 0),
        'Magdalena', AppColors.red,
        isPublic: true),
    CalendarEvent(
      11,
      'Cena de Gala',
      DateTime(2024, 12, 7, 18, 0),
      'San Miguel',
      AppColors.pink,
      isPublic: true,
    ),
    CalendarEvent(
      12,
      'Fiesta de Cierre',
      DateTime(2025, 1, 7, 21, 0),
      'Callao',
      AppColors.blue,
      isFavorite: true,
      isPublic: true,
    ),
  ];

  //GETTERS
  List<CalendarEvent> get events => _events;

  //FUNCTIONS
  List<CalendarEvent> getFutureEvents() {
    DateTime now = DateTime.now();
    List<CalendarEvent> futureEvents =
        events.where((event) => event.date.isAfter(now)).toList();

    futureEvents.sort((a, b) => a.date.compareTo(b.date));

    return futureEvents;
  }

  List<CalendarEvent> getFavoriteEvents() {
    DateTime now = DateTime.now();
    List<CalendarEvent> futureEvents = events
        .where((event) => event.date.isAfter(now) && event.isFavorite)
        .toList();

    futureEvents.sort((a, b) => a.date.compareTo(b.date));

    return futureEvents;
  }

  List<CalendarEvent> getPublicEvents() {
    DateTime now = DateTime.now();
    List<CalendarEvent> futureEvents = events
        .where((event) => event.date.isAfter(now) && event.isPublic)
        .toList();

    futureEvents.sort((a, b) => a.date.compareTo(b.date));

    return futureEvents;
  }
}
