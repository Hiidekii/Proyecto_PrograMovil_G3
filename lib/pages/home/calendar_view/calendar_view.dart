import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/calendar_controller.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/componets/calendar_view_app_bar.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/componets/calendar_view_event_card.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/componets/calendar_view_table_calendar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    // Inyectar el controlador para que esté disponible en toda la vista
    final CalendarController controller = Get.put(CalendarController());

    return Scaffold(
      appBar: const CalendarViewAppBar(),
      body: Column(
        children: [
          // Usamos el controlador con las observables
          const CalendarViewTableCalendar(),

          // Se utiliza Obx para actualizar la UI cuando cambian los eventos del día seleccionado
          Obx(() {
            if (controller.getEventsForSelectedDay().isEmpty) {
              return const Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 180),
                      child: Text("No hay eventos para este día",
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              );
            } else {
              final events = controller.getEventsForSelectedDay();
              return Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                ),
              );
            }
          }),
        ],
      ),
      backgroundColor: AppColors.softYellow,
    );
  }
}
