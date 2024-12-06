import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/pages/events/components/event_card.dart';
import 'package:proyecto_programovil_g3/pages/events/components/section_header.dart';
import 'package:proyecto_programovil_g3/pages/events/new_event.dart/new_event_page.dart';
import 'package:proyecto_programovil_g3/pages/events/events_page_view_model.dart';

class EventsTab extends StatelessWidget {
  final EventsPageViewModel controller = Get.put(EventsPageViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${controller.errorMessage.value}'),
                ElevatedButton(
                  onPressed: controller.refreshEvents,
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshEvents,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              if (controller.adminEvents.isNotEmpty) ...[
                const SectionHeader(title: 'Mis eventos'),
                ...controller.adminEvents.map((event) => EventCard(
                      title: event.title,
                      date: event.dateTime.toString().substring(0, 10),
                      time: event.dateTime.toString().substring(11, 16),
                      imageUrl: event.thumbnail,
                      onEdit: () {},
                      onShare: () {},
                      onManage: () {},
                      isEditable: true,
                      isFavorite: event.isFavourite ?? false,
                      onTap: () => controller.navigateToEventDetail(event.id),
                    )),
              ],
              if (controller.favoriteEvents.isNotEmpty) ...[
                const SectionHeader(title: 'Favoritos'),
                ...controller.favoriteEvents.map((event) => EventCard(
                      title: event.title,
                      date: event.dateTime.toString().substring(0, 10),
                      time: event.dateTime.toString().substring(11, 16),
                      imageUrl: event.thumbnail,
                      onEdit: null,
                      onShare: () {},
                      onManage: null,
                      isEditable: false,
                      isFavorite: true,
                      onTap: () => controller.navigateToEventDetail(event.id),
                    )),
              ],
              if (controller.guestEvents.isNotEmpty) ...[
                const SectionHeader(title: 'Mis planes'),
                ...controller.guestEvents.map((event) => EventCard(
                      title: event.title,
                      date: event.dateTime.toString().substring(0, 10),
                      time: event.dateTime.toString().substring(11, 16),
                      imageUrl: event.thumbnail,
                      onEdit: null,
                      onShare: () {},
                      onManage: null,
                      isEditable: false,
                      isFavorite: event.isFavourite ?? false,
                      onTap: () => controller.navigateToEventDetail(event.id),
                    )),
              ],
            ],
          ),
        );
      }),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(right: 5, bottom: 100),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (BuildContext context) {
                return NewEventPage();
              },
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.yellow[700],
        ),
      ),
    );
  }
}
