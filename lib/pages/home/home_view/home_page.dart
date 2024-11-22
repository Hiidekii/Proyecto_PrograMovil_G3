import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_page_all_events.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_page_favorite_events%20.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_page_public_events%20.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/home_controller.dart';
import 'package:shimmer/shimmer.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.delete<HomeController>(force: true);
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.refreshEvents();
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Próximos Eventos',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (controller.userEvents.isEmpty) {
                return _buildShimmerEffect();
              } else {
                return const HomePageUserEvents();
              }
            }),
            const Padding(
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
            Obx(() {
              if (controller.publicEvents.isEmpty) {
                return _buildShimmerEffect();
              } else {
                return const HomePageFavoritesEvents();
              }
            }),
            const Padding(
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
            Obx(() {
              if (controller.publicEvents.isEmpty) {
                return _buildShimmerEffect();
              } else {
                return const HomePagePublicEvents();
              }
            }),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:
              5, // You can set this to a reasonable count for loading items
          itemBuilder: (context, index) {
            return Container(
              width: 200,
              height: 250,
              margin: const EdgeInsets.only(right: 10),
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }
}
