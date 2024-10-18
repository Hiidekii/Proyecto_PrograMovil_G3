// event_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_detail_card_view.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_list_view.dart';
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
          return ListView(
            children: [
              EventDetailCard(
                title: event.title,
                description: event.description,
                thumbnail: event.thumbnail,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () => controller.changeTab(0),
                      child: const Text('La Ubi'),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () => controller.changeTab(1),
                      child: const Text('La Lista'),
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () => controller.changeTab(2),
                      child: const Text('La Gente'),
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
          );
        }),
      ),
    );
  }
}
