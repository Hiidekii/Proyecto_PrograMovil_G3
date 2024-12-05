import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/components/q_sale_error_manager.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/event_detail_view_model.dart';
import 'package:proyecto_programovil_g3/models/Events/event_category_item_response.dart';

class AddItemModalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventDetailViewModel controller = Get.find<EventDetailViewModel>();

    final TextEditingController itemNameController = TextEditingController();
    final TextEditingController itemAmountController = TextEditingController();
    final FocusNode amountFocusNode =
        FocusNode(); // FocusNode para manejar el teclado

    // Obtener las categorías de forma reactiva
    controller.getCategories();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Añadir Ítem',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            // Hacer que el Row de categorías sea desplazable horizontalmente
            Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          controller.selectCategory(category);
                          // Cerrar el teclado cuando se cambia la categoría
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: controller.selectedItemCategory.value ==
                                    category
                                ? Colors.blueAccent
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: controller.selectedItemCategory.value ==
                                      category
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                          child: Text(
                            category.type,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: controller.selectedItemCategory.value ==
                                      category
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
            TextField(
              controller: itemNameController,
              decoration: InputDecoration(
                hintText: 'Nombre del ítem',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final isFloatable =
                  controller.selectedItemCategory.value.floatable;

              return TextField(
                controller: itemAmountController,
                focusNode: amountFocusNode,
                keyboardType:
                    TextInputType.numberWithOptions(decimal: isFloatable),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(isFloatable ? r'^\d+(\.\d{0,2})?' : r'^\d+$'),
                  ),
                ],
                decoration: InputDecoration(
                  hintText: 'Cantidad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    controller.toggleItemModal();
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    final String itemName = itemNameController.text.trim();
                    final double? amount =
                        double.tryParse(itemAmountController.text);

                    if (itemName.isNotEmpty && amount != null && amount > 0) {
                      controller.createEventItem(itemName, amount);
                    } else {
                      SnackbaManager().showError("Complete todos los campos");
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
