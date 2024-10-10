import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  final String title;
  final String date;
  final String itemDescription;
  final String itemValue;
  final String moneyDescription;
  final String moneyValue;
  final bool isItemConfirmed;
  final bool isMoneyConfirmed;
  final String imageUrl;
  final bool isEditable; // Asegúrate de agregar este parámetro
  final bool isFavorite; // Y este también

  const EventDetailScreen({
    Key? key,
    required this.title,
    required this.date,
    required this.itemDescription,
    required this.itemValue,
    required this.moneyDescription,
    required this.moneyValue,
    required this.isItemConfirmed,
    required this.isMoneyConfirmed,
    required this.imageUrl,
    required this.isEditable, // Asegúrate de incluirlo aquí
    required this.isFavorite, // Y también este
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imageUrl),
            SizedBox(height: 16.0),
            Text(
              'Fecha: $date',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '$itemDescription: $itemValue',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '$moneyDescription: $moneyValue',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(
                  isItemConfirmed ? Icons.check_circle : Icons.error,
                  color: isItemConfirmed ? Colors.green : Colors.red,
                ),
                SizedBox(width: 10.0),
                Text(
                  'Item Confirmado: ${isItemConfirmed ? 'Sí' : 'No'}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(
                  isMoneyConfirmed ? Icons.check_circle : Icons.error,
                  color: isMoneyConfirmed ? Colors.green : Colors.red,
                ),
                SizedBox(width: 10.0),
                Text(
                  'Dinero Confirmado: ${isMoneyConfirmed ? 'Sí' : 'No'}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
