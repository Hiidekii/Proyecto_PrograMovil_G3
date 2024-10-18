import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/event_detaiL_view.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_page_event_card.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/home_controller.dart';

class HomePageAllEvents extends StatelessWidget {
  const HomePageAllEvents({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Expanded(
      child: Column(
        children: [
          Obx(() {
            final events = controller.userEvents;
            return Container(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailScreen(
                            id: event.id,
                          ),
                        ),
                      )
                    },
                    child: HomePageEventCard(event: event),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
