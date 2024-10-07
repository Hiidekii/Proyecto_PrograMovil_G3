import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/pages/events/components/event_card.dart';
import 'package:proyecto_programovil_g3/pages/events/components/section_header.dart';

class EventsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SectionHeader(title: 'Mis eventos'),
          EventCard(
            title: 'Cumpleaños de Hideki',
            date: '21/10/24',
            time: '21:00',
            imageUrl: 'assets/img/E1.png',
            onEdit: () {},
            onShare: () {},
            onManage: () {},
            isEditable: true,
            isFavorite: false,
          ),
          SectionHeader(title: 'Favoritos'),
          EventCard(
            title: 'Cumpleaños de Hideki',
            date: '21/10/24',
            time: '21:00',
            imageUrl: 'assets/img/E2.png',
            onEdit: null,
            onShare: () {},
            onManage: null,
            isEditable: false,
            isFavorite: true,
          ),
          SectionHeader(title: 'Mis planes'),
          EventCard(
            title: 'Cumpleaños de Hideki',
            date: '21/10/24',
            time: '21:00',
            imageUrl: 'assets/img/E3.png',
            onEdit: null,
            onShare: () {},
            onManage: null,
            isEditable: false,
            isFavorite: false,
          ),
        ],
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(right: 10),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          backgroundColor: Colors.yellow[700],
        ),
      ),
    );
  }
}
