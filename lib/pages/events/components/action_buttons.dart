import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/pages/events/components/action_button.dart';

class ActionButtons extends StatelessWidget {
  final int? selectedButtonIndex;
  final Function(int) onButtonPressed;

  const ActionButtons({
    Key? key,
    required this.selectedButtonIndex,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton(
          icon: Icons.location_on,
          label: 'El point',
          isSelected: selectedButtonIndex == 0,
          onPressed: () => onButtonPressed(0),
        ),
        ActionButton(
          icon: Icons.view_list_rounded,
          label: 'Listas',
          isSelected: selectedButtonIndex == 1,
          onPressed: () => onButtonPressed(1),
        ),
        ActionButton(
          icon: Icons.people_alt_rounded,
          label: 'Gente',
          isSelected: selectedButtonIndex == 2,
          onPressed: () => onButtonPressed(2),
        ),
      ],
    );
  }
}
