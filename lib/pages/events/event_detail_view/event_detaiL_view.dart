import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/extensions/date_extensions.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_detail_card_view.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_list/event_list_view.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/event_detail_view_model.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_map_view.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_people_view.dart';

class EventDetailScreen extends StatelessWidget {
  final int id;

  EventDetailScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    Get.delete<EventDetailViewModel>(force: true);
    final EventDetailViewModel controller = Get.put(EventDetailViewModel(id));

    // Cargar los detalles del evento
    controller.loadEventDetail();

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Detalle del evento',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      )),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.loadRefresh();
        },
        child: Obx(() {
          final event = controller.event.value;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
            child: ListView(
              children: [
                EventDetailCard(
                  title: event.title,
                  description: event.description,
                  thumbnail: event.thumbnail,
                  date: event.dateTime.formatToCustomString(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CustomButton(
                      onPressed: () => controller.changeTab(0),
                      icon: Icons.map,
                      label: 'Ubi',
                    ),
                    const SizedBox(width: 10),
                    _CustomButton(
                      onPressed: () => controller.changeTab(1),
                      icon: Icons.list,
                      label: 'Lista',
                    ),
                    const SizedBox(width: 10),
                    _CustomButton(
                      onPressed: () => controller.changeTab(2),
                      icon: Icons.people,
                      label: 'Gente',
                    ),
                  ],
                ),

                // Sub-vistas que cambian con los botones
                Obx(() {
                  if (controller.selectedIndex.value == 0) {
                    return EventMapView(
                      key: ValueKey(event.location.formattedAddress),
                      eventLocation: event.location,
                    );
                  } else if (controller.selectedIndex.value == 1) {
                    return ListSection();
                  } else {
                    return EventPeopleView(
                      key: ValueKey(controller.event.value.id),
                      users: controller.event.value.members ?? [],
                    );
                  }
                }),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color color;

  const _CustomButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.color = AppColors.yellow, // Cambié 'required' a 'this' para el color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: color, // Utiliza el color proporcionado
            borderRadius: BorderRadius.circular(20.0),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 1,
            //     blurRadius: 3,
            //     offset: const Offset(0, 3),
            //   ),
            // ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white), // Color del icono
              const SizedBox(width: 8), // Espacio entre icono y texto
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
