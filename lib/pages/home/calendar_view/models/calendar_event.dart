// Clase para los eventos (puedes personalizarla según tus necesidades)
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarEvent {
  final int id;
  final String title;
  final DateTime date;
  final String location;
  final Color color;
  final bool isFavorite;
  final bool isPublic;
  CalendarEvent(this.id, this.title, this.date, this.location, this.color,
      {this.isFavorite = false, this.isPublic = false});

  String getFormattedTime() {
    return DateFormat('HH:mm').format(date);
  }

  String getFormattedDate() {
    return DateFormat('EEEE d MMMM', 'es_ES').format(date);
  }
}
