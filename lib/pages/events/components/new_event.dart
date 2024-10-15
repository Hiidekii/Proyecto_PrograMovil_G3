import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';

class NewEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Título "Nuevo evento"
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Nuevo evento',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBackgroundColor,
                ),
              ),
            ),
            // Categoría
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _categoryButton(
                    context, 'Reu', Colors.orange, CupertinoIcons.person_2),
                SizedBox(width: 8),
                _categoryButton(
                    context, 'Cumple', Colors.blue, CupertinoIcons.piano),
                SizedBox(width: 8),
                _categoryButton(
                    context, 'After', Colors.pink, CupertinoIcons.hifispeaker),
              ],
            ),
            SizedBox(height: 16),
            _buildTextField(CupertinoIcons.tickets, 'Título'),
            SizedBox(height: 2),
            _buildTextField(CupertinoIcons.calendar, 'Fecha'),
            SizedBox(height: 2),
            _buildTextField(CupertinoIcons.time, 'Hora'),
            SizedBox(height: 2),
            _buildTextField(CupertinoIcons.text_alignleft, 'Descripción'),
            SizedBox(height: 2),
            _buildTextField(CupertinoIcons.location_solid, 'Ubicación'),
            SizedBox(height: 2),
            _buildTextField(CupertinoIcons.music_note, 'Link de playlist'),
            SizedBox(height: 2),
            _buildTextField(CupertinoIcons.chat_bubble_text, 'Link de chat'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Aceptar'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[700]),
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _categoryButton(
      BuildContext context, String text, Color color, IconData icon) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.black),
          SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildTextField(IconData icon, String hintText) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.darkBackgroundColor),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.grey),
    );
  }
}

void showNewEventModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return NewEvent();
    },
  );
}
