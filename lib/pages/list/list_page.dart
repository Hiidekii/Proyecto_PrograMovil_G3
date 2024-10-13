import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_screen.dart';
import 'package:proyecto_programovil_g3/pages/list/components/list_card.dart';
import 'package:proyecto_programovil_g3/pages/list/components/section_header.dart';

class ListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SectionHeader(title: 'Mis eventos'),
          EventCard(
            title: 'Cumpleaños de Hideki',
            date: '13/12/24',
            itemDescription: 'Papitas',
            itemValue: '5',
            moneyDescription: 'Local',
            moneyValue: '300',
            isItemConfirmed: true,
            isMoneyConfirmed: true,
            imageUrl: 'assets/img/E1.png',
            isEditable: true,  // Añadir este argumento
            isFavorite: false,  // Añadir este argumento
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EventDetailScreen(
                    title: 'Cumpleaños de Hideki',
                    date: '13/12/24',
                    itemDescription: 'Papitas',
                    itemValue: '5',
                    moneyDescription: 'Local',
                    moneyValue: '300',
                    isItemConfirmed: true,
                    isMoneyConfirmed: true,
                    imageUrl: 'assets/img/E1.png',
                    isEditable: true,
                    isFavorite: false,
                  ),
                ),
              );
            },
          ),
          // Añadir más EventCard con onTap para navegación
        ],
      ),
    );
  }
}
