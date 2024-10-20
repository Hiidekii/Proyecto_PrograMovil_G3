import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/extensions/date_extensions.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_detail_card_view.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_list_view.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/event_detail_view_model.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_map_view.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_people_view.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_page_event_basic_card.dart';

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
        title: Obx(() {
          return Text('${controller.event.value.title}');
        }),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.loadRefresh();
        },
        child: Obx(() {
          final event = controller.event.value;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListView(
              children: [
                EventDetailCard(
                  title: event.title,
                  description: event.description,
                  thumbnail: event.thumbnail,
                  date: event.dateTime.formatToCustomString(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.changeTab(0),
                        icon: const Icon(Icons.map), // Ícono para La Ubi
                        label: const Text('Ubi'),
                      ),
                    ),
                    const SizedBox(width: 8), // Espaciado entre botones
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.changeTab(1),
                        icon: const Icon(Icons.list), // Ícono para La Lista
                        label: const Text('Lista'),
                      ),
                    ),
                    const SizedBox(width: 8), // Espaciado entre botones
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.changeTab(2),
                        icon: const Icon(Icons.people), // Ícono para La Gente
                        label: const Text('Gente'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Espacio entre botones y vistas

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
