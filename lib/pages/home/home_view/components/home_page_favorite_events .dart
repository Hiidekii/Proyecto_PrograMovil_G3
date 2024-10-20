import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX
import 'package:proyecto_programovil_g3/components/q_sale_image.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/extensions/date_extensions.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/event_detaiL_view.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_page_event_basic_card.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/home_controller.dart';

class HomePageFavoritesEvents extends StatelessWidget {
  const HomePageFavoritesEvents({super.key});

  @override
  Widget build(BuildContext context) {
    // Usa Get.find() para obtener el controlador
    final HomeController controller = Get.find<HomeController>();

    return Expanded(
      child: Column(
        children: [
          Container(
            height: 300,
            child: Obx(() {
              final events =
                  controller.getFavourites(); // Asumiendo que es una RxList
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  // final isFavorite = event.isFavourite ?? false;
                  return HomePageEventBasicCard(event: event);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
