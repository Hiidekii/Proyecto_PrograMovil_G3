import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/models/GoogleMaps/place_response.dart';
import 'package:proyecto_programovil_g3/pages/events/new_event.dart/new_event_view_model.dart'; // Importa el controlador

class LocationModal extends StatelessWidget {
  const LocationModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewEventViewModel controller = Get.find();

    return Container(
      padding: const EdgeInsets.all(5.0), // Mantiene el padding del contenido
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width *
                0.9, // 70% del ancho de la pantalla
            child: TextField(
              onChanged: (value) {
                controller.searchText.value = value;
                controller.searchLocations(value);
              },
              decoration: const InputDecoration(
                labelText: 'Ingresa el lugar',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Obx(() {
            return controller.places.isEmpty
                ? const Center(
                    child: Text(
                      'No se encontraron lugares.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      itemCount: controller.places.length,
                      itemBuilder: (context, index) {
                        final place = controller.places[index];
                        return ListTile(
                          title: Text("Lugar: ${place.displayName.text}"),
                          subtitle: Text(place.formattedAddress),
                          onTap: () {
                            controller.selectedPlace.value = Place(
                                formattedAddress: place.formattedAddress,
                                location: place.location,
                                displayName: place.displayName);
                            Navigator.pop(context, place);
                          },
                        );
                      },
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
