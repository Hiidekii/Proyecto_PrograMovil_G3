import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';

class ListSection extends StatefulWidget {
  const ListSection({Key? key}) : super(key: key);

  @override
  _ListSectionState createState() => _ListSectionState();
}

class _ListSectionState extends State<ListSection> {
  String?
      selectedValue; // Puedes utilizarlo para otros propósitos si es necesario

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
          16.0), // Espaciado alrededor de todo el contenido
      child: Card(
        color: AppColors.yellow,
        elevation: 1, // Sombra de la tarjeta
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
        ),
        child: const Column(
          children: [
            SizedBox(height: 10),
            ExpansionTile(
              tilePadding: EdgeInsets.symmetric(
                  horizontal: 20), // Quita el padding del tile
              collapsedIconColor: Colors.black, // Color del icono colapsado
              iconColor: Colors.black, // Color del icono expandido
              title: Text(
                'Detalles',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  child: Text(
                    'Aquí van los detalles sobre la opción seleccionada.',
                    style: TextStyle(
                        fontSize: 16, color: Colors.white), // Texto blanco
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
