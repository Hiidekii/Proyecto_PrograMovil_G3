import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_page_all_events.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_page_favorite_events%20.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_page_public_events%20.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/home_controller.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Usar Get.put para instanciar el controlador si no se ha creado antes
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Próximos Eventos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          HomePageAllEvents(), // Actualiza aquí
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Favoritos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.red,
                  ),
                ),
              ],
            ),
          ),
          HomePageFavoritesEvents(), // Actualiza aquí
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Eventos Públicos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.blue,
                  ),
                ),
              ],
            ),
          ),
          // HomePagePublicEvents(), // Actualiza aquí
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
