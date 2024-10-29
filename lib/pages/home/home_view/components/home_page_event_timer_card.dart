import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/components/q_sale_image.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/extensions/date_extensions.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/event_detail_view.dart';

class HomePageEventTimerCard extends StatelessWidget {
  final EventDataResponse event;

  const HomePageEventTimerCard({super.key, required this.event});

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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailScreen(
              id: event.id,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          children: [
            // TIMER
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white, // Color sólido
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: StreamBuilder<Duration>(
                      stream: _countdownStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          final remainingTime = snapshot.data!;
                          final days = remainingTime.inDays;
                          final hours = remainingTime.inHours % 24;
                          final minutes = remainingTime.inMinutes % 60;
                          final seconds = remainingTime.inSeconds % 60;

                          return Text(
                            '$days d: $hours h: $minutes m: $seconds s',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'Evento ya pasado',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            // DETALLES DEL EVENTO
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.red, // Color sólido
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: QSaleImage(
                        imgUrlString: event.thumbnail,
                        width: 70,
                        height: 120,
                        borderRadius: 10,
                      ),
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
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.calendar,
                                  color: Colors.white,
                                  size: 22,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  event.dateTime.formatToCustomString(
                                      format: 'dd/MM/yy - HH:mm'),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
                                  size: 22,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    event.location.displayName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
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
      ),
    );
  }
}
