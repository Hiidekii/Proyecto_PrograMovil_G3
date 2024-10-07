import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/calendar_view_model.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewTableCalendar extends StatelessWidget {
  final CalendarViewModel viewModel;

  // Constructor para inicializar el `viewModel`
  const CalendarViewTableCalendar({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cream, // Cambia a AppColors.cream si lo necesitas
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: TableCalendar(
          locale: 'es_ES',
          focusedDay: viewModel.focusedDay,
          selectedDayPredicate: (day) => day == viewModel.selectedDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarFormat: viewModel.calendarFormat,
          onDaySelected: (selectedDay, focusedDay) {
            viewModel.setSelectedDay(selectedDay);
            viewModel.setFocusedDay(focusedDay);
          },
          firstDay: DateTime.now().add(const Duration(days: -1000)),
          onFormatChanged: (format) {
            viewModel.setCalendarFormat(format);
          },
          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
          ),
          lastDay: DateTime.utc(2100, 12, 12),
        ),
      ),
    );
  }
}
