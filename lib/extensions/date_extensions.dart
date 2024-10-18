import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

extension DateTimeExtensions on DateTime {
  String formatToCustomString(
      {String format = 'EEEE d \'de\' MMMM',
      String timeZone = 'America/Lima'}) {
    final location = tz.getLocation(timeZone);
    final localTime = tz.TZDateTime.from(this, location);
    return DateFormat(format, 'es').format(localTime);
  }

  bool isToday() {
    final now = DateTime.now();
    return this.year == now.year &&
        this.month == now.month &&
        this.day == now.day;
  }
}
