import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/calendar_view.dart';
import 'package:proyecto_programovil_g3/pages/home/home_view/home_view_model.dart';

class HomeViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final HomeViewModel viewModel;

  const HomeViewAppBar({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Inicio',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(
            CupertinoIcons.search,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            CupertinoIcons.calendar,
            color: Colors.black,
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (BuildContext context) {
                return const CalendarView();
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(
            CupertinoIcons.bell,
            color: Colors.black, // Ícono en color negro
          ),
          onPressed: () {},
        ),
      ],
      backgroundColor: AppColors.cream, // Fondo de la AppBar
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
