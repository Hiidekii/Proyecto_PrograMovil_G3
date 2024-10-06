import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/componets/calendar_view_event_card.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_page_all_events.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_page_favorite_events%20.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/components/home_view_app_bar.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/home_view_model.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: HomeViewAppBar(viewModel: viewModel),
          backgroundColor: AppColors.cream,
          body: ListView(
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
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              HomePageAllEvents(viewModel: viewModel),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Favoritos',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              HomePageFavoritesEvents(viewModel: viewModel)
            ],
          ),
        ),
      ),
    );
  }
}
