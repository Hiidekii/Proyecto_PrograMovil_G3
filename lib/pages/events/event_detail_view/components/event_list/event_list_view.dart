import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/components/q_sale_custom_button.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_list/components/event_list_widget.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/event_detail_view_model.dart';

class ListSection extends StatelessWidget {
  final EventDetailViewModel controller = Get.find<EventDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          Obx(() {
            return Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón de "Agregar Item" más grande
                  Expanded(
                    flex: 2, // Hace que este botón ocupe más espacio
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      height: 80,
                      child: CustomButton(
                        onPressed: () {
                          controller.toggleItemModal();
                        },
                        icon: CupertinoIcons.cart_fill_badge_plus,
                        label: "Agregar Item",
                        color: Colors.green,
                      ),
                    ),
                  ),
                  // Botón de "Editar"
                  Expanded(
                    flex: 1, // Ocupa el espacio restante
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      height: 80,
                      child: CustomButton(
                        onPressed: () {
                          controller.toggleEditMode();
                        },
                        icon: CupertinoIcons.pencil,
                        label: "Editar",
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: controller.event.value.lista.map((category) {
                  return Column(
                    children: [
                      ListWidget(
                        category: category,
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  );
                }).toList(),
              )
            ]);
          }),
        ],
      ),
    );
  }
}
