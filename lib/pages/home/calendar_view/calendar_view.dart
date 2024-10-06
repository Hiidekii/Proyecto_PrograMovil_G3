import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/calendar_view_model.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/componets/calendar_view_app_bar.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/componets/calendar_view_event_card.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/componets/calendar_view_table_calendar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalendarViewModel(),
      child: Consumer<CalendarViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: CalendarViewAppBar(viewModel: viewModel),
          body: Column(
            children: [
              CalendarViewTableCalendar(viewModel: viewModel),
              if (viewModel.getEventsForSelectedDay().isEmpty)
                const Expanded(
                    child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 180),
                      child: Text("No hay eventos para este día",
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ))
              else
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final events = viewModel.getEventsForSelectedDay();
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          bool isLastEvent = index == events.length - 1;
                          return Column(
                            children: [
                              CalendarEventCard(
                                  event: event, isLastEvent: isLastEvent),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
          backgroundColor: AppColors.softYellow,
        ),
      ),
    );
  }
}
