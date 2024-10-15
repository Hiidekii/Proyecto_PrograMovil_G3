import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'components/action_buttons.dart';
import 'components/event_detail_card.dart';
import 'components/event_image.dart';
import 'components/location_section.dart';
import 'components/list_section.dart';
import 'components/people_section.dart';

class EventDetailScreen extends StatefulWidget {
  final String title;
  final String date;
  final String itemDescription;
  final String itemValue;
  final String moneyDescription;
  final String moneyValue;
  final bool isItemConfirmed;
  final bool isMoneyConfirmed;
  final String imageUrl;
  final VoidCallback? onEdit;
  final VoidCallback? onShare;
  final VoidCallback? onManage;
  final bool isEditable;
  final bool isFavorite;

  const EventDetailScreen({
    super.key,
    required this.title,
    required this.date,
    required this.itemDescription,
    required this.itemValue,
    required this.moneyDescription,
    required this.moneyValue,
    required this.isItemConfirmed,
    required this.isMoneyConfirmed,
    required this.imageUrl,
    this.onEdit,
    this.onShare,
    this.onManage,
    required this.isEditable,
    required this.isFavorite,
  });

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  int? selectedButtonIndex; // Track which button is selected

  final TextEditingController _searchController = TextEditingController();

  List<Person> people = [
    Person("Hideki", "assets/img/E1.png"),
    Person("Kohji", "assets/img/E2.png"),
    Person("Walter", "assets/img/E3.png"),
    Person("Luis", "assets/img/E4.png"),
    Person("Alvaro", "assets/img/E1.png"),
  ];
  List<Person> filteredPeople = [];

/*   List<Aportantes> aportantes = [
    Aportantes("Hideki", "assets/img/E1.png", 600, "Confirmado", "Dinero"),
    Aportantes("Kohji", "assets/img/E2.png", 300, "Confirmado", "Dinero"),
    Aportantes("Walter", "assets/img/E3.png", 3, "Confirmado", "Bebida"),
    Aportantes("Luis", "assets/img/E4.png", 3, "Confirmado", "Bebida"),
    Aportantes("Alvaro", "assets/img/E1.png", 3, "Confirmado", "Comida"),
  ] */

  List<Lista> listas = [
    Lista("Comida", "Lista de comestibles", 40),
    Lista("Bebida", "Lista de bebidas", 30),
    Lista("Dinero", "La jato del tono", 500),
  ];
  List<Lista> filteredListas = [];

  Map<String, List<Map<String, dynamic>>> categoryItems = {
    "Dinero": [
      {
        "name": "Kohji",
        "quantity": "150",
        "status": "Done",
        "userImgUrl": "assets/img/E1.png"
      },
      {
        "name": "Hideki",
        "quantity": "150",
        "status": "TBD",
        "userImgUrl": "assets/img/E2.png"
      }
    ],
    "Bebida": [
      {
        "name": "Ron",
        "quantity": "3",
        "status": "Done",
        "userImgUrl": "assets/img/E1.png"
      },
      {
        "name": "Vodka",
        "quantity": "4",
        "status": "TBD",
        "userImgUrl": "assets/img/E2.png"
      }
    ],
    "Comida": [
      {
        "name": "Papitas",
        "quantity": "2",
        "status": "Done",
        "userImgUrl": "assets/img/E1.png"
      },
      {
        "name": "Chips",
        "quantity": "3",
        "status": "TBD",
        "userImgUrl": "assets/img/E2.png"
      }
    ]
  };

  @override
  void initState() {
    super.initState();
    filteredPeople = List.from(people);
    filteredListas = List.from(listas);
  }

  GoogleMapController? mapController;

  final LatLng _eventLocation =
      LatLng(-12.046374, -77.042793); // Coordenadas de ejemplo

  void _onButtonPressed(int index) {
    setState(() {
      selectedButtonIndex = index; // Update selected button index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles del evento"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    EventCard(title: widget.title, date: widget.date),
                    EventImage(imageUrl: widget.imageUrl),
                  ],
                ),
                const SizedBox(height: 20),
                ActionButtons(
                  selectedButtonIndex: selectedButtonIndex,
                  onButtonPressed: _onButtonPressed,
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildSectionContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContent() {
    switch (selectedButtonIndex) {
      case 0:
        return const LocationSection(
            eventLocation: LatLng(-12.046374, -77.042793));
      case 1:
        return ListSection(
          filteredListas: filteredListas,
          searchController: _searchController,
          onSearch: _onSearchList,
          categoryItems: categoryItems,
        );
      case 2:
        return PeopleSection(
          filteredPeople: filteredPeople,
          searchController: _searchController,
          onSearch: _onSearchPeople,
          onAddPerson: _showAddPersonDialog,
        );
      default:
        return ListSection(
          filteredListas: filteredListas,
          searchController: _searchController,
          onSearch: _onSearchList,
          categoryItems: categoryItems,
        );
    }
  }

  void _onSearchList(String value) {
    setState(() {
      filteredListas = listas
          .where(
              (lista) => lista.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _onSearchPeople(String value) {
    setState(() {
      filteredPeople = people
          .where((person) =>
              person.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

// Función para mostrar el diálogo (popup) para agregar más personas
  void _showAddPersonDialog(BuildContext context) {
    TextEditingController _nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invitar gente'),
          content: TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'Nombre de la persona'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el popup
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Agregar la nueva persona a la lista
                  people.add(Person(_nameController.text, "assets/img/E4.png"));
                  filteredPeople = people;
                });
                Navigator.of(context)
                    .pop(); // Cerrar el popup después de agregar
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

/* class Aportantes {
  final String name;
  final String avatarUrl;
  final int aporte;
  final String category;
  final String status;

  Aportantes(this.name, this.avatarUrl, this.aporte, this.status, this.category);

} */

  // Widget _buildPeopleSection() {
  //   String text = 'Sección de personas asociadas al evento';
  //   return Container(
  //     padding: const EdgeInsets.all(16.0),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.black54),
  //       borderRadius: BorderRadius.circular(8.0),
  //     ),
  //     child: Text(
  //       text,
  //       style: const TextStyle(fontSize: 16),
  //       textAlign: TextAlign.center,
  //     ),
  //   );
}
