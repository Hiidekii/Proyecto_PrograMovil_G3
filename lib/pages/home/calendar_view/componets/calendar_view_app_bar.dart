import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/extensions/date_extensions.dart';
import 'package:proyecto_programovil_g3/pages/home/calendar_view/calendar_view_model.dart';

class CalendarViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final CalendarViewModel viewModel;

  const CalendarViewAppBar({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        viewModel.selectedDay.isToday()
            ? 'Hoy'
            : viewModel.selectedDay.formatToCustomString(),
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.softGray,
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              icon: const Icon(CupertinoIcons.xmark),
              color: Colors.white,
              onPressed: () {
                viewModel.dismissView(context);
              },
            ),
          ),
        ),
      ],
      backgroundColor: AppColors.cream,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
