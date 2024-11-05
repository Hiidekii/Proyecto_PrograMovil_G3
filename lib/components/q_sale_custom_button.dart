import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color color;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.color = AppColors.yellow, // Cambié 'required' a 'this' para el color
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: color, // Utiliza el color proporcionado
            borderRadius: BorderRadius.circular(20.0),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 1,
            //     blurRadius: 3,
            //     offset: const Offset(0, 3),
            //   ),
            // ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white), // Color del icono
              const SizedBox(width: 8), // Espacio entre icono y texto
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
