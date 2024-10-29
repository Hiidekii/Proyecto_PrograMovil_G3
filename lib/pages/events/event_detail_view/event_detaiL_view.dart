import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/components/q_sale_custom_button.dart';
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
        ),
        actions: [
          IconButton(
            icon: const Text(
              "Editar",
              style: TextStyle(
                  color: AppColors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              // Acción al presionar el botón
              print("Botón de información presionado");
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.loadRefresh();
        },
        child: Obx(() {
          final event = controller.event.value;
          return Stack(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
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
                        CustomButton(
                          onPressed: () => controller.changeTab(0),
                          icon: Icons.map,
                          label: 'Ubi',
                        ),
                        const SizedBox(width: 10),
                        CustomButton(
                          onPressed: () => controller.changeTab(1),
                          icon: Icons.list,
                          label: 'Lista',
                        ),
                        const SizedBox(width: 10),
                        CustomButton(
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
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    height: 100,
                    child: CustomButton(
                      onPressed: () {
                        print("CONFIRMAR");
                      },
                      icon: Icons.check,
                      label: "Confirmar Asistencia",
                      color: Colors.green,
                    ),
                  )
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
