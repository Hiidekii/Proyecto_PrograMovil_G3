import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/pages/list/components/list_card.dart';
import 'package:proyecto_programovil_g3/pages/list/components/section_header.dart';

class ListTab extends StatelessWidget {
  const ListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SectionHeader(title: 'Mis eventos'),
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
            onEdit: () {},
            onShare: () {},
            onManage: () {},
            isEditable: true,
            isFavorite: false,
          ),
          const SectionHeader(title: 'Favoritos'),
          EventCard(
            title: 'Cumpleaños de Hideki',
            date: '13/12/24',
            itemDescription: 'Papitas',
            itemValue: '5',
            moneyDescription: 'Entra',
            moneyValue: '300',
            isItemConfirmed: true,
            isMoneyConfirmed: false,
            imageUrl: 'assets/img/E2.png',
            onEdit: () {},
            onShare: () {},
            onManage: () {},
            isEditable: true,
            isFavorite: false,
          ),
          const SectionHeader(title: 'Mis planes'),
          EventCard(
            title: 'Cumpleaños de Hideki',
            date: '13/12/24',
            itemDescription: 'Piqueo',
            itemValue: '5',
            moneyDescription: 'Colab',
            moneyValue: '300',
            isItemConfirmed: false,
            isMoneyConfirmed: true,
            imageUrl: 'assets/img/E3.png',
            onEdit: () {},
            onShare: () {},
            onManage: () {},
            isEditable: true,
            isFavorite: false,
          ),
        ],
      ),
    );
  }
}
