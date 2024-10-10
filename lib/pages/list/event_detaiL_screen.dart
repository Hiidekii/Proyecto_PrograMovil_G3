import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';

class EventDetailScreen extends StatefulWidget {
  final String title;
  final String date;
  final String itemDescription;
  final String itemValue;
  final String moneyDescription;
  final String moneyValue;
  final bool isItemConfirmed;
  final bool isMoneyConfirmed;
  final String imageUrl;
  final VoidCallback? onEdit;
  final VoidCallback? onShare;
  final VoidCallback? onManage;
  final bool isEditable;
  final bool isFavorite;

  const EventDetailScreen({
    super.key,
    required this.title,
    required this.date,
    required this.itemDescription,
    required this.itemValue,
    required this.moneyDescription,
    required this.moneyValue,
    required this.isItemConfirmed,
    required this.isMoneyConfirmed,
    required this.imageUrl,
    this.onEdit,
    this.onShare,
    this.onManage,
    required this.isEditable,
    required this.isFavorite,
  });

  @override
  _EventDetailScreenState createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  int? selectedButtonIndex; // Track which button is selected

  void _onButtonPressed(int index) {
    setState(() {
      selectedButtonIndex = index; // Update selected button index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del evento"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                _buildCard(context),
                _buildImage(),
              ],
            ),
            SizedBox(height: 20),
            _buildActionButtons(context), // Action buttons
            SizedBox(height: 20),
            _buildSectionContent(), // Display content based on selected button
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5,
      margin: EdgeInsets.only(left: 95.0, right: 4.0, top: 10.0, bottom: 10.0),
      color: Colors.black54,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9E3D62), Color(0xFF2E2E5B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.only(
            left: 9.0,
            right: 5.0,
            top: 0.0,
            bottom: 21.0,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            '${widget.date}',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Positioned(
      left: 4,
      top: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          height: 95,
          width: 83,
          child: Image.asset(
            widget.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildElevatedButton(
          context,
          Icons.location_on,
          'El point', // Label for the first button
          () => _onButtonPressed(0), // Handle button press
          selectedButtonIndex == 0, // Check if selected
        ),
        _buildElevatedButton(
          context,
          Icons.view_list_rounded,
          'Listas', // Label for the second button
          () => _onButtonPressed(1), // Handle button press
          selectedButtonIndex == 1, // Check if selected
        ),
        _buildElevatedButton(
          context,
          Icons.people_alt_rounded,
          'Gentita', // Label for the third button
          () => _onButtonPressed(2), // Handle button press
          selectedButtonIndex == 2, // Check if selected
        ),
      ],
    );
  }

  Widget _buildElevatedButton(
      BuildContext context, IconData icon, String label, VoidCallback onPressed, bool isSelected) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blueAccent : Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Rounded shape
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding for the button
        elevation: isSelected ? 8 : 4, // Increase elevation when selected
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Button size will depend on its content
        children: [
          Icon(
            icon,
            color: AppColors.getTextColor(context),
          ),
          SizedBox(width: 8), // Space between icon and label
          Text(
            label,
            style: TextStyle(color: AppColors.getTextColor(context)), // Set label color
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContent() {
    String text = '';
    switch (selectedButtonIndex) {
      case 0:
        text = 'Sección de ubicación asociada al evento';
        break;
      case 1:
        text = 'Sección de listas asociadas al evento';
        break;
      case 2:
        text = 'Sección de personas asociadas al evento';
        break;
      default:
        text = 'Seleccione una sección';
        break;
    }

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
