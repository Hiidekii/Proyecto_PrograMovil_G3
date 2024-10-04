import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/components/bottom_bar.dart';
import 'package:proyecto_programovil_g3/pages/events/events_page.dart';
import 'package:proyecto_programovil_g3/pages/home/home_page.dart';
import 'package:proyecto_programovil_g3/pages/profile/profile_page.dart';

class Wrapper extends StatefulWidget {
  final Function onToggleTheme; // Para alternar el tema

  Wrapper({required this.onToggleTheme}); // Constructor

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeTab(), // Asegúrate de que HomeTab esté correctamente definido
    EventsTab(), // Asegúrate de que EventsTab esté correctamente definido
    ProfileTab(), // Asegúrate de que ProfileTab esté correctamente definido
  ];

  // Lista de títulos para cada pestaña
  final List<String> _titles = [
    'Inicio',
    'Eventos',
    'Perfil',
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Actualiza el índice actual
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _titles[_currentIndex]), // Cambia el título según el índice actual
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.event),
            onPressed: () {},
          ),
          Switch(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (value) {
              widget.onToggleTheme(); // Cambia el tema al presionar
            },
          ),
        ],
      ),
      body:
          _children[_currentIndex], // Muestra el widget según el índice actual
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        onTabTapped: onTabTapped, // Pasar la función para cambiar de pestañas
      ),
    );
  }
}
