import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSection extends StatelessWidget {
  final LatLng eventLocation;

  const LocationSection({Key? key, required this.eventLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dirección del evento:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text('Av. Ejemplo 123, Ciudad Ejemplo'),
          SizedBox(height: 16),
          Container(
            height: 300,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: eventLocation,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('eventLocation'),
                  position: eventLocation,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
