import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  BottomBar({required this.currentIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Color(0xFFF7F0E9), // Color de fondo claro
          borderRadius: BorderRadius.circular(
              25), // Bordes redondeados en todas las esquinas
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Sombra suave
              blurRadius: 10, // Difuminado de la sombra
              offset: Offset(0, 5), // Desplazamiento de la sombra
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTabTapped,
          backgroundColor: Colors.transparent, // Fondo transparente
          type: BottomNavigationBarType.fixed, // Fija el tamaño de los ítems
          elevation: 0, // Sin sombra o elevación
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 32, color: Colors.black87),
              activeIcon:
                  Icon(Icons.home, size: 32, color: Colors.orangeAccent),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory, size: 32, color: Colors.black87),
              activeIcon:
                  Icon(Icons.inventory, size: 32, color: Colors.orangeAccent),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist, size: 32, color: Colors.black87),
              activeIcon:
                  Icon(Icons.checklist, size: 32, color: Colors.orangeAccent),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet,
                  size: 32, color: Colors.black87),
              activeIcon: Icon(Icons.account_balance_wallet,
                  size: 32, color: Colors.orangeAccent),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view, size: 32, color: Colors.black87),
              activeIcon:
                  Icon(Icons.grid_view, size: 32, color: Colors.orangeAccent),
              label: '',
            ),
          ],
          selectedItemColor: Colors.orangeAccent, // Color del ítem seleccionado
          unselectedItemColor:
              Colors.black87, // Color de los ítems no seleccionados
          showSelectedLabels: false, // Oculta etiquetas
          showUnselectedLabels: false, // Oculta etiquetas no seleccionadas
        ),
      ),
    );
  }
}
