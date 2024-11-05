import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {
  String formatToCustomString({String format = 'HH:mm'}) {
    // Convierte TimeOfDay a DateTime en la fecha actual
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, this.hour, this.minute);
    return DateFormat(format, 'es_ES').format(dateTime);
  }

  bool isNow() {
    final now = TimeOfDay.now();
    return this.hour == now.hour && this.minute == now.minute;
  }
}
