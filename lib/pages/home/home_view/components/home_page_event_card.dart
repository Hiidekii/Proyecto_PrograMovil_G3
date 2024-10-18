import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/components/q_sale_image.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/extensions/date_extensions.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';

class HomePageEventCard extends StatelessWidget {
  final EventDataResponse event;

  const HomePageEventCard({super.key, required this.event});

  Stream<Duration> _countdownStream() async* {
    DateTime eventDateTime = event.dateTime;

    while (true) {
      DateTime now = DateTime.now();
      Duration remainingTime = eventDateTime.difference(now);

      if (remainingTime.isNegative) {
        yield Duration.zero;
        break;
      }

      yield remainingTime;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // TIMER
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.blue, // Cambia el color a tu preferencia
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: StreamBuilder<Duration>(
                stream: _countdownStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final remainingTime = snapshot.data!;
                    final days = remainingTime.inDays;
                    final hours = remainingTime.inHours % 24;
                    final minutes = remainingTime.inMinutes % 60;
                    final seconds = remainingTime.inSeconds % 60;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$days d: $hours h: $minutes m: $seconds s',
                          style: const TextStyle(
                            fontSize: 16,
                            color:
                                Colors.white, // Cambia a blanco para contraste
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                        child: Text('Evento ya pasado',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)));
                  }
                },
              ),
            ),
          ),
          // DETALLES DEL EVENTO
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: QSaleImage(
                        imgUrlString: event.thumbnail,
                        width: 70,
                        height: 120,
                        borderRadius: 10),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2, // Limitar a dos líneas
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.calendar,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                event.dateTime.formatToCustomString(
                                    format: 'dd/MM/yy - HH:mm'),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.location,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                event.location.displayName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2, // Limitar a dos líneas
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
