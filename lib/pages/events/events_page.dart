import 'package:flutter/material.dart';

class EventsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Agregar funcionalidad de búsqueda
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Agregar funcionalidad de notificaciones
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SectionHeader(title: 'Mis eventos'),
          EventCard(
            title: 'Cumpleaños de Hideki',
            date: '21/10/24',
            time: '21:00',
            imageUrl: 'assets/images/event_image.png', // imagen local o en la red
            onEdit: () {
              // Lógica para editar el evento
            },
            onShare: () {
              // Lógica para compartir el evento
            },
            onManage: () {
              // Lógica para gestionar el evento
            },
          ),
          // Puedes agregar más EventCards aquí o iterar sobre una lista de eventos.
          SectionHeader(title: 'Favoritos'),
          EventCard(
            title: 'Cumpleaños de Hideki',
            date: '21/10/24',
            time: '21:00',
            imageUrl: 'assets/images/event_image.png',
            onEdit: null, // En favoritos no necesitas editar
            onShare: () {
              // Lógica para compartir el evento
            },
            onManage: null, // No necesitas gestionar en favoritos
          ),
          SectionHeader(title: 'Mis planes'),
          EventCard(
            title: 'Cumpleaños de Hideki',
            date: '21/10/24',
            time: '21:00',
            imageUrl: 'assets/images/event_image.png',
            onEdit: null,
            onShare: () {
              // Lógica para compartir el evento
            },
            onManage: null,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica para crear un nuevo evento
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.yellow[700], // Color de tu imagen
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

// Componente para la tarjeta de eventos
class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String imageUrl;
  final VoidCallback? onEdit;
  final VoidCallback? onShare;
  final VoidCallback? onManage;

  const EventCard({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.imageUrl,
    this.onEdit,
    this.onShare,
    this.onManage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(10.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(imageUrl, fit: BoxFit.cover, width: 60, height: 60),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$date - $time'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onEdit != null)
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: onEdit,
              ),
            if (onShare != null)
              IconButton(
                icon: Icon(Icons.share),
                onPressed: onShare,
              ),
            if (onManage != null)
              IconButton(
                icon: Icon(Icons.event),
                onPressed: onManage,
              ),
          ],
        ),
      ),
    );
  }
}
