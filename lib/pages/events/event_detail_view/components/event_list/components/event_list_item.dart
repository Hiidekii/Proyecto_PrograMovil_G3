
import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';

class ListItemWidget extends StatelessWidget {
  final String name;
  final double quantity;
  final String status;
  final String userImgUrl;
  final bool isFloatable;
  const ListItemWidget({
    super.key,
    required this.name,
    required this.quantity,
    required this.status,
    required this.userImgUrl,
    required this.isFloatable,
  });

  @override
  Widget build(BuildContext context) {
    IconData iconStatus;
    Color iconStatusColor;

    if (status == "Done") {
      iconStatus = Icons.check_circle_outline_rounded;
      iconStatusColor = Colors.green;
    } else {
      iconStatus = Icons.access_time_rounded;
      iconStatusColor = AppColors.yellow;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 25,
            backgroundImage: NetworkImage(userImgUrl),
          ),
          const SizedBox(width: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 5), // Opcional: agregar padding
            decoration: BoxDecoration(
              color: Colors.white, // Color de fondo
              borderRadius: BorderRadius.circular(15.0), // Borde redondeado
            ),
            child: Text(
              '${isFloatable ? quantity : quantity.toInt()}',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight
                      .bold), // Cambiar el color del texto si es necesario
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            iconStatus,
            size: 25,
            color: iconStatusColor,
          ),
        ],
      ),
    );
  }
}
