import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_list/components/event_list_widget.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/event_detail_view_model.dart';

class ListSection extends StatelessWidget {
  final EventDetailViewModel controller = Get.find<EventDetailViewModel>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Obx(() {
            return Column(
              children: controller.event.value.lista.map((category) {
                return Column(
                  children: [
                    ListWidget(
                      category: category,
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                );
              }).toList(),
            );
          }),
        ],
      ),
    );
  }
}
