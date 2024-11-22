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

  void _showConfirmationDialog(BuildContext context, EventDetailViewModel controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cambiar Asistencia'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Por Confirmar'),
                onTap: () {
                  controller.updateAttendance('Por Confirmar');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Confirmar'),
                onTap: () {
                  controller.updateAttendance('Confirmado');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('No asistirá'),
                onTap: () {
                  controller.updateAttendance('No asistirá');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.delete<EventDetailViewModel>(force: true);
    final EventDetailViewModel controller = Get.put(EventDetailViewModel(id));

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
          Obx(() {
            final currentUserRole = controller.getCurrentUserRole();
            if (currentUserRole == 'Admin') {
              return IconButton(
                icon: const Text(
                  "Editar",
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onPressed: () {
                  // Acción de edición
                  print("Botón de edición presionado");
                },
              );
            }
            return SizedBox.shrink();
          }),
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
                    const SizedBox(height: 50),
                  ],
                ),
              ),
              Column(
                children: [
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    height: 100,
                    child: Obx(() {
                      final userConfirmation = controller.getCurrentUserConfirmation();
                      final isConfirmed = userConfirmation == 'Confirmado';
                      
                      return CustomButton(
                        onPressed: () {
                          if (isConfirmed) {
                            _showConfirmationDialog(context, controller);
                          } else {
                            controller.updateAttendance('Confirmado');
                          }
                        },
                        icon: isConfirmed ? Icons.edit : Icons.check,
                        label: isConfirmed ? "Cambiar Asistencia" : "Confirmar Asistencia",
                        color: isConfirmed ? Colors.blue : Colors.green,
                      );
                    }),
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
