import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String formatToCustomString({String format = 'EEEE d \'de\' MMMM'}) {
    return DateFormat(format, 'es_ES').format(this);
  }

  bool isToday() {
    final now = DateTime.now();
    return this.year == now.year &&
        this.month == now.month &&
        this.day == now.day;
  }
}
