import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String imageUrl;
  final VoidCallback? onEdit;
  final VoidCallback? onShare;
  final VoidCallback? onManage;
  final bool isEditable;
  final bool isFavorite;

  const EventCard({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.imageUrl,
    this.onEdit,
    this.onShare,
    this.onManage,
    required this.isEditable,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCard(context),
        _buildImage(),
        _buildActions(context),
      ],
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
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            '$date - $time',
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
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Positioned(
      right: 10,
      top: 18,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildActionButton(
            context,
            isEditable
                ? CupertinoIcons.pencil
                : (isFavorite
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.heart),
            isEditable ? onEdit : onShare,
          ),
          SizedBox(height: 6),
          _buildActionButton(
            context,
            Icons.checklist,
            onManage,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, IconData icon, VoidCallback? onPressed) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.getTextColor(context)),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }
  
}
