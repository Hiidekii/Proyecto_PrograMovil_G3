import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_programovil_g3/models/Events/event_location_response.dart';
import 'package:url_launcher/url_launcher.dart'; // Asegúrate de añadir esta dependencia en tu pubspec.yaml

class EventMapView extends StatelessWidget {
  final EventLocationResponse eventLocation;

  const EventMapView({Key? key, required this.eventLocation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Construir el enlace de Google Maps utilizando el place_id
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=${eventLocation.latitude},${eventLocation.longitude}&query_place_id=${eventLocation.placeId}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                onPressed: () async {
                  final Uri googleMapsUri = Uri.parse(googleMapsUrl);
                  if (await canLaunchUrl(googleMapsUri)) {
                    await launchUrl(googleMapsUri);
                  } else {
                    throw 'No se pudo abrir $googleMapsUrl';
                  }
                },
                child: const Text(
                  'Ver en Google Maps',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // Color del botón
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
