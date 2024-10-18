import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_programovil_g3/models/Events/event_location_response.dart';

class EventMapView extends StatelessWidget {
  final EventLocationResponse eventLocation;

  const EventMapView({Key? key, required this.eventLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5, // Sombra de la tarjeta
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dirección del evento:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87, // Color más suave
                ),
              ),
              const SizedBox(height: 8),
              Text(
                eventLocation.displayName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                eventLocation.formattedAddress,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 15),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
                child: Container(
                  height: 250,
                  width: double.infinity,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          eventLocation.latitude, eventLocation.longitude),
                      zoom: 16.0,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('eventLocation'),
                        position: LatLng(
                            eventLocation.latitude, eventLocation.longitude),
                        infoWindow: InfoWindow(
                          title: eventLocation.displayName,
                          snippet: eventLocation.formattedAddress,
                        ),
                      ),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      Future.delayed(const Duration(milliseconds: 100), () {
                        controller.showMarkerInfoWindow(
                            const MarkerId('eventLocation'));
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  // Abre Google Maps con la dirección del evento
                  // Aquí puedes implementar la lógica para abrir Google Maps
                },
                child: const Text('Ver en Google Maps'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red, // Color del botón
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
