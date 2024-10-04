import 'package:flutter/material.dart';

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
            imageUrl: 'assets/img/E1.png', // imagen local
            onEdit: () {
              // Lógica para editar el evento
            },
            onShare: () {
              // Lógica para compartir el evento
            },
            onManage: () {
              // Lógica para gestionar el evento
            },
            isEditable: true, // Establecer si el evento es editable
            isFavorite: false, // Establecer si es favorito
          ),
          // Puedes agregar más EventCards aquí o iterar sobre una lista de eventos.
          SectionHeader(title: 'Favoritos'),
          EventCard(
            title: 'Cumpleaños de Hideki',
            date: '21/10/24',
            time: '21:00',
            imageUrl: 'assets/img/E2.png', // imagen local
            onEdit: null, // En favoritos no necesitas editar
            onShare: () {
              // Lógica para compartir el evento
            },
            onManage: null, // No necesitas gestionar en favoritos
            isEditable: false,
            isFavorite: true, // Este es un favorito
          ),
          SectionHeader(title: 'Mis planes'),
          EventCard(
            title: 'Cumpleaños de Hideki',
            date: '21/10/24',
            time: '21:00',
            imageUrl: 'assets/img/E3.png', // imagen local
            onEdit: null,
            onShare: () {
              // Lógica para compartir el evento
            },
            onManage: null,
            isEditable: false,
            isFavorite: false, // No es favorito
          ),
        ],
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(right: 10), // Padding a la derecha
        child: FloatingActionButton(
          onPressed: () {
            // Lógica para crear un nuevo evento
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.yellow[700],
        ),
      ),
    );
  }
}

// Componente para el encabezado de cada sección
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String imageUrl;
  final VoidCallback? onEdit;
  final VoidCallback? onShare;
  final VoidCallback? onManage;
  final bool isEditable; // Para saber si el evento es editable
  final bool isFavorite; // Para saber si es favorito

  const EventCard({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.imageUrl,
    this.onEdit,
    this.onShare,
    this.onManage,
    required this.isEditable,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Card con fondo oscuro y bordes redondeados
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5,
          margin: EdgeInsets.only(
              left: 100.0, right: 10.0, top: 10.0, bottom: 10.0),
          color: Colors.black54, // Fondo oscuro
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/img/Fondo_lista.png'), // Imagen de fondo fija
                fit: BoxFit.cover, // Ajuste de la imagen al tamaño del Card
              ), // Texto en blanco
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(9.0),
              title: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Texto en blanco
                ),
              ),
              subtitle: Text(
                '$date - $time',
                style:
                    TextStyle(color: Colors.white70), // Texto en blanco suave
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40, // Tamaño cuadrado
                    height: 40, // Tamaño cuadrado
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor, // Usa el color de fondo del tema activo
                      borderRadius: BorderRadius.circular(
                          8), // Borde ligeramente redondeado
                    ),
                    child: IconButton(
                      icon: Icon(Icons.checklist,
                          color: Colors.white), // El color del icono
                      onPressed: onManage,
                    ),
                  ),
                  SizedBox(width: 8), // Espacio entre los iconos
                  Container(
                    width: 40, // Tamaño cuadrado
                    height: 40, // Tamaño cuadrado
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor, // Usa el color de fondo del tema activo
                      borderRadius: BorderRadius.circular(
                          8), // Borde ligeramente redondeado
                    ),
                    child: IconButton(
                      icon: Icon(
                        isEditable
                            ? Icons.edit
                            : (isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border),
                        color: Colors.white, // El color del icono
                      ),
                      onPressed: isEditable
                          ? onEdit
                          : () {
                              // Lógica para manejar favoritos
                            },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Imagen fuera del Card
        Positioned(
          left: 10,
          top: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.cover,
              width: 83,
              height: 83,
            ),
          ),
        ),
      ],
    );
  }
}
