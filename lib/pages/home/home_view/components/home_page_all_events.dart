import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/componets/calendar_view_event_card.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_page_event_card.dart';

import 'package:proyecto_programovil_g3/pages/home/home_view/home_view_model.dart';

class HomePageAllEvents extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomePageAllEvents({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Builder(
        builder: (context) {
          final events = viewModel.getFutureEvents();
          return Column(
            children: [
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return HomePageEventCard(event: event);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
