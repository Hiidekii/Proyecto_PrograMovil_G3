import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  @override
  void initState() {
    super.initState();
    filteredPeople = List.from(people);
  }

  GoogleMapController? mapController;

  final LatLng _eventLocation = LatLng(-12.046374, -77.042793); // Coordenadas de ejemplo

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
                    _buildCard(context),
                    _buildImage(),
                  ],
                ),
                const SizedBox(height: 20),
                _buildActionButtons(context),
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

  Widget _buildCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5,
      margin: const EdgeInsets.only(left: 95.0, right: 4.0, top: 10.0, bottom: 10.0),
      color: Colors.black54,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF9E3D62), Color(0xFF2E2E5B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(
            left: 9.0,
            right: 5.0,
            top: 0.0,
            bottom: 21.0,
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            widget.date,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Positioned(
      left: 4,
      top: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: SizedBox(
          height: 95,
          width: 83,
          child: Image.asset(
            widget.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildElevatedButton(
          context,
          Icons.location_on,
          'El point', // Label for the first button
          () => _onButtonPressed(0), // Handle button press
          selectedButtonIndex == 0, // Check if selected
        ),
        _buildElevatedButton(
          context,
          Icons.view_list_rounded,
          'Listas', // Label for the second button
          () => _onButtonPressed(1), // Handle button press
          selectedButtonIndex == 1, // Check if selected
        ),
        _buildElevatedButton(
          context,
          Icons.people_alt_rounded,
          'Gentita', // Label for the third button
          () => _onButtonPressed(2), // Handle button press
          selectedButtonIndex == 2, // Check if selected
        ),
      ],
    );
  }

  Widget _buildElevatedButton(
      BuildContext context, IconData icon, String label, VoidCallback onPressed, bool isSelected) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blueAccent : AppColors.getBackgroundColor(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Rounded shape
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding for the button
        elevation: isSelected ? 8 : 4, // Increase elevation when selected
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Button size will depend on its content
        children: [
          Icon(
            icon,
            color: AppColors.getTextColor(context),
          ),
          const SizedBox(width: 8), // Space between icon and label
          Text(
            label,
            style: TextStyle(color: AppColors.getTextColor(context)), // Set label color
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContent() {
    switch (selectedButtonIndex) {
      case 0:
        return _buildLocationSection(); // Sección de ubicación
      case 1:
        return _buildListSection();
      case 2:
        return _buildPeopleSection();
      default:
        return const Text('Seleccione una sección');
    }
  }

  Widget _buildLocationSection() {
  return Padding(
    padding: const EdgeInsets.all(16.0), // Aquí añades el padding a todo el contenido
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dirección del evento:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 8),
        Text('Av. Ejemplo 123, Ciudad Ejemplo'), // Dirección del evento
        SizedBox(height: 16),
        Container(
          height: 300, // Altura del mapa
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            myLocationEnabled: true, // Asegúrate de tener permisos
            initialCameraPosition: CameraPosition(
              target: _eventLocation, // Coordenadas del evento
              zoom: 14.0,
            ),
            markers: {
              Marker(
                markerId: MarkerId('eventLocation'),
                position: _eventLocation,
              ),
            },
          ),
        ),
      ],
    ),
  );
}


  Widget _buildListSection() {
    String text = 'Sección de listas asociadas al evento';
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }

 Widget _buildPeopleSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildSearchBar(),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: filteredPeople.length,
            itemBuilder: (context, index) {
              return _buildPersonTile(filteredPeople[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: AppColors.getBackgroundColor(context),
      borderRadius: BorderRadius.circular(30),
    ),
    child: TextField(
      onChanged: (value) {
        setState(() {
          filteredPeople = people
              .where((person) =>
                  person.name.toLowerCase().contains(value.toLowerCase()))
              .toList();
        });
      },
      controller: _searchController, // Controlador para manejar el texto
      decoration: InputDecoration(
        hintText: 'Buscar',
        border: InputBorder.none,
        prefixIcon: const Icon(Icons.search), // Icono de lupa dentro del borde
        suffixIcon: _searchController.text.isNotEmpty // Muestra el icono de "equis" si hay texto
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _searchController.clear(); // Limpia el campo de búsqueda
                    filteredPeople = people; // Resetea la lista filtrada
                  });
                },
              )
            : null, // No muestra nada si no hay texto
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.getBorderColor(context), // Color del borde
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.getFocusedBorderColor(context), // Color del borde al enfocarse
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      style: TextStyle(color: AppColors.getTextColor(context)),
    ),
  );
}



  Widget _buildPersonTile(Person person) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.getBackgroundColor(context),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundImage: AssetImage(person.avatarUrl),
            radius: 25,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              person.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Person {
  final String name;
  final String avatarUrl;

  Person(this.name, this.avatarUrl);
}

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
  // }

