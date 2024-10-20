import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/components/q_sale_image.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/extensions/date_extensions.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/event_detaiL_view.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/home_controller.dart';

class HomePageEventBasicCard extends StatelessWidget {
  final EventDataResponse event;

  const HomePageEventBasicCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final isFavorite = event.isFavourite ?? false;

    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailScreen(
              id: event.id,
            ),
          ),
        )
      },
      child: Container(
        width: 200,
        height: 300,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Imagen del evento
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: QSaleImage(
                imgUrlString: event.thumbnail,
                width: 200,
                height: 300,
                imgScale: BoxFit.cover,
              ),
            ),
            // Gradiente sobre la imagen
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            // Título y detalles del evento
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.dateTime.formatToCustomString(
                      format: 'dd/MM/yy - HH:mm',
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            // Icono de favorito
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: () {
                  controller.setFavouriteState(
                    event.id,
                    isFavorite,
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isFavorite) // Solo mostrar el relleno si es favorito
                      Icon(
                        CupertinoIcons.heart_fill,
                        size: 28,
                        color: Colors.red,
                      ),
                    Icon(
                      CupertinoIcons.heart, // El ícono contorno siempre visible
                      weight: 10,
                      size: 28,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
