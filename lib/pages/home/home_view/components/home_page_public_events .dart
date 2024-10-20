import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_page_event_basic_card.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/home_controller.dart';

import '../../../events/event_detail_view/event_detaiL_view.dart';

class HomePagePublicEvents extends StatelessWidget {
  const HomePagePublicEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find(); // Obtener el controlador

    return Expanded(
      child: Obx(() {
        final events = controller.publicEvents; // Accede a los eventos públicos

        return Column(
          children: [
            Container(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final EventDataResponse event = events[index];

                  return Row(
                    children: [
                      HomePageEventBasicCard(event: event),
                      const SizedBox(width: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
