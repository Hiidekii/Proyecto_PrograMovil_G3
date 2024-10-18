import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX
import 'package:proyecto_programovil_g3/components/q_sale_image.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/extensions/date_extensions.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/event_detaiL_view.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/home_controller.dart';

class HomePageFavoritesEvents extends StatelessWidget {
  const HomePageFavoritesEvents({super.key});

  @override
  Widget build(BuildContext context) {
    // Usa Get.find() para obtener el controlador
    final HomeController controller = Get.find<HomeController>();

    return Expanded(
      child: Column(
        children: [
          Container(
            height: 300,
            child: Obx(() {
              final events =
                  controller.getFavourites(); // Asumiendo que es una RxList
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
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
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              QSaleImage(
                                imgUrlString: event.thumbnail,
                                width: 200,
                                height: 300,
                              ),
                              Container(
                                width: 200,
                                height: 300,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // viewModel.toggleFavorite(
                                            //     event); // Cambia el estado del favorito
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                  blurRadius: 10,
                                                  spreadRadius: 1,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Icon(
                                              isFavorite
                                                  ? CupertinoIcons.heart_fill
                                                  : CupertinoIcons.heart,
                                              size: 30,
                                              color: isFavorite
                                                  ? Colors.red
                                                  : Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(10),
                                      padding: const EdgeInsets.all(5),
                                      height: 80,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: AppColors.cream.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            event.title,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            event.dateTime.formatToCustomString(
                                                format: 'dd/MM/yy - HH:mm'),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
