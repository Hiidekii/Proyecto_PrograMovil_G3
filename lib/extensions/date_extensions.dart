import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String formatToCustomString({String format = 'EEEE d \'de\' MMMM'}) {
    return DateFormat(format, 'es_ES').format(this);
  }

  bool isToday() {
    final now = DateTime.now();
    return year == now.year &&
        month == now.month &&
        day == now.day;
  }
}
