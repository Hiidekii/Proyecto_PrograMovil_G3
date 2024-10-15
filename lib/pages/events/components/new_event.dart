import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NewEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _categoryButton(context, 'Reu', Colors.orange),
                _categoryButton(context, 'Cumple', Colors.blue),
                _categoryButton(context, 'After', Colors.pink),
              ],
            ),
            SizedBox(height: 16),
            _buildTextField(CupertinoIcons.pencil, 'Título'),
            SizedBox(height: 8),
            _buildTextField(CupertinoIcons.calendar, 'Fecha'),
            SizedBox(height: 8),
            _buildTextField(CupertinoIcons.time, 'Hora'),
            SizedBox(height: 8),
            _buildTextField(CupertinoIcons.text_alignleft, 'Descripción'),
            SizedBox(height: 8),
            _buildTextField(CupertinoIcons.location, 'Ubicación'),
            SizedBox(height: 8),
            _buildTextField(CupertinoIcons.music_note, 'Link de playlist'),
            SizedBox(height: 8),
            _buildTextField(CupertinoIcons.chat_bubble_text, 'Link de chat'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Aceptar'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[700]),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _categoryButton(BuildContext context, String text, Color color) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(text),
      style: ElevatedButton.styleFrom(backgroundColor: color),
    );
  }

  Widget _buildTextField(IconData icon, String hintText) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}

void showNewEventModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return NewEvent();
    },
  );
}
