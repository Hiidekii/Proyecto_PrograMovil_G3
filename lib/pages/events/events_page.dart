import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/pages/events/components/event_card.dart';
import 'package:proyecto_programovil_g3/pages/events/components/section_header.dart';
import 'package:proyecto_programovil_g3/pages/events/new_event.dart/new_event_page.dart'; // Asegúrate de importar esta clase

class EventsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const EventDetailScreen(
              //       title: 'Cumpleaños de Hideki',
              //       date: '21/10/24',
              //       itemDescription: 'Descripción del evento',
              //       itemValue: '5',
              //       moneyDescription: 'Local',
              //       moneyValue: '300',
              //       isItemConfirmed: true,
              //       isMoneyConfirmed: true,
              //       imageUrl: 'assets/img/E1.png',
              //       isEditable: false,
              //       isFavorite: true,
              //     ),
              //   ),
              // );
            },
          ),
          SectionHeader(title: 'Favoritos'),
          EventCard(
            title: 'Cumpleaños de Luis',
            date: '13/12/24',
            time: '21:00',
            imageUrl: 'assets/img/E2.png',
            onEdit: null,
            onShare: () {},
            onManage: null,
            isEditable: false,
            isFavorite: true,
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const EventDetailScreen(
              //       title: 'Cumpleaños de Luis',
              //       date: '13/10/24',
              //       itemDescription: 'Descripción del evento',
              //       itemValue: '5',
              //       moneyDescription: 'Local',
              //       moneyValue: '300',
              //       isItemConfirmed: true,
              //       isMoneyConfirmed: true,
              //       imageUrl: 'assets/img/E2.png',
              //       isEditable: false,
              //       isFavorite: true,
              //     ),
              //   ),
              // );
            },
          ),
          SectionHeader(title: 'Mis planes'),
          EventCard(
            title: 'Cumpleaños de Kohji',
            date: '06/10/24',
            time: '21:00',
            imageUrl: 'assets/img/E3.png',
            onEdit: null,
            onShare: () {},
            onManage: null,
            isEditable: false,
            isFavorite: false,
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const EventDetailScreen(
              //       title: 'Cumpleaños de Kohji',
              //       date: '06/10/24',
              //       itemDescription: 'Descripción del evento',
              //       itemValue: '5',
              //       moneyDescription: 'Local',
              //       moneyValue: '300',
              //       isItemConfirmed: true,
              //       isMoneyConfirmed: true,
              //       imageUrl: 'assets/img/E3.png',
              //       isEditable: false,
              //       isFavorite: false,
              //     ),
              //   ),
              // );
            },
          ),
        ],
      ),
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
