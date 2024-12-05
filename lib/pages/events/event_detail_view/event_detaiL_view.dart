import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/components/q_sale_custom_button.dart';
import 'package:proyecto_programovil_g3/extensions/date_extensions.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_detail_card_view.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_list/components/add_item_modal_view.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_list/event_list_view.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/event_detail_view_model.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_map_view.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_people_view.dart';

class EventDetailScreen extends StatelessWidget {
  final int id;

  EventDetailScreen({required this.id});

  void _showConfirmationDialog(
      BuildContext context, EventDetailViewModel controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cambiar Asistencia'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Por Confirmar'),
                onTap: () {
                  controller.updateAttendance(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Confirmar'),
                onTap: () {
                  controller.updateAttendance(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('No asistirá'),
                onTap: () {
                  controller.updateAttendance(3);
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
    // Inicia o reinicia el controlador para esta pantalla.
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
          CupertinoButton(
            padding: EdgeInsets.only(right: 20),
            onPressed: () {},
            child: const Icon(
              CupertinoIcons
                  .ellipses_bubble_fill, // Aquí pones el icono que deseas
              color: Colors.black,
              size: 28, // Ajusta el tamaño del icono según lo necesites
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              controller.loadRefresh();
            },
            child: Obx(() {
              final event = controller.event.value;
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 80)
                ],
              );
            }),
          ),
          Column(
            children: [
              const Spacer(),
              Obx(() {
                final userConfirmation =
                    controller.getCurrentUserConfirmation();
                final isConfirmed = userConfirmation == 'Confirmado';
                if (isConfirmed) {
                  return SizedBox.shrink();
                }
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  height: 100,
                  child: CustomButton(
                    onPressed: () {
                      if (isConfirmed) {
                        _showConfirmationDialog(context, controller);
                      } else {
                        controller.updateAttendance(2);
                      }
                    },
                    icon: Icons.check,
                    label: "Confirmar Asistencia",
                    color: Colors.green,
                  ),
                );
              }),
            ],
          ),
          Obx(() {
            if (controller.isAddItemModalOpen.value) {
              return GestureDetector(
                onTap: () {}, // Evitar cerrar el modal tocando fuera.
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: AddItemModalView(),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
