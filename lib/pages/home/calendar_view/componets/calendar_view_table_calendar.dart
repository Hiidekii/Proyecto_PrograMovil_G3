import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/calendar_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewTableCalendar extends StatelessWidget {
  const CalendarViewTableCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el controlador usando Get.find()
    final CalendarController controller = Get.find<CalendarController>();

    return Container(
      color: AppColors.cream,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Obx(() => TableCalendar(
              locale: 'es_ES',
              focusedDay: controller.focusedDay.value,
              selectedDayPredicate: (day) =>
                  day == controller.selectedDay.value,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarFormat: controller.calendarFormat.value,
              onDaySelected: (selectedDay, focusedDay) {
                controller.setSelectedDay(selectedDay);
                controller.setFocusedDay(focusedDay);
              },
              firstDay: DateTime.now().add(const Duration(days: -1000)),
              onFormatChanged: (format) {
                controller.setCalendarFormat(format);
              },
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
              lastDay: DateTime.utc(2100, 12, 12),
            )),
      ),
    );
  }
}
