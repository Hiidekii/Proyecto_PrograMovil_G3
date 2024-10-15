import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/components/q_sale_image.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/extensions/date_extensions.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/models/calendar_event.dart';

class HomePageEventCard extends StatelessWidget {
  final CalendarEvent event;

  const HomePageEventCard({super.key, required this.event});

  Stream<Duration> _countdownStream() async* {
    DateTime eventDateTime = event.date;

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
        margin: const EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            //TIMER XD
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
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
                              '${days}d:${hours}h:${minutes}m:${seconds}s',
                              style: const TextStyle(
                                fontSize: 15,
                                color: AppColors.textColor,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                            child: Text('Evento ya pasado',
                                style: TextStyle(color: Colors.red)));
                      }
                    },
                  ),
                ),
              ],
            ),
            //DETALLES DEL EVENTO
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: event.color,
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
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: const QSaleImage(
                            imgUrlString: "https://picsum.photos/200/200",
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            event.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            overflow: TextOverflow.fade,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            event.date.formatToCustomString(
                                format: 'dd/MM/yy - HH:mm'),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
