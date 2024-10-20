import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/components/q_sale_image.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';

class EventDetailCard extends StatelessWidget {
  final String title;
  final String description;
  final String thumbnail;
  final String date; // Nueva propiedad para la fecha

  const EventDetailCard({
    Key? key,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.date, // Asegúrate de inicializarla en el constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.softRed,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinear elementos al inicio
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: QSaleImage(
              key: ValueKey(thumbnail),
              width: 100,
              imgUrlString: thumbnail,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Cambiar color del texto
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date, // Mostrar la fecha
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70, // Color más suave para la fecha
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
