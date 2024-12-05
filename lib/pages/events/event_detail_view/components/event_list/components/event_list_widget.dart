import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/models/Events/event_category_response.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_list/components/event_exapansion_list.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/event_detail_view_model.dart';

class ListWidget extends StatelessWidget {
  final CategoryResponse category;
  ListWidget({super.key, required this.category});

  final EventDetailViewModel controller = Get.find<EventDetailViewModel>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              category.type,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        EventExapansionList(
          categoryItems: category.items ?? [],
          categoryType: category.categoryType ?? EventCategoryType.chancha,
          aportarFunct: (itemID, amount) =>
              controller.addUserItem(itemID, amount),
          isEditable: controller.isEditedModeActivated.value,
          eliminarItem: (int itemId) => controller.deleteEventItem(itemId),
        )
      ],
    );
  }
}
