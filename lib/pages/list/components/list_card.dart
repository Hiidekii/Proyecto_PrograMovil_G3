import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';

class EventCard extends StatelessWidget {
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

  const EventCard({
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
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5,
          margin:
              EdgeInsets.only(left: 95.0, right: 4.0, top: 10.0, bottom: 10.0),
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
                top: 6.0,
                bottom: 6.0,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
              subtitle: Column(
                children: [
                  SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildItemInfo(itemDescription, itemValue,
                          isItemConfirmed, false, context),
                      SizedBox(width: 5.0),
                      _buildItemInfo(moneyDescription, moneyValue,
                          isMoneyConfirmed, true, context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
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
        ),
      ],
    );
  }

  Widget _buildItemInfo(String label, String value, bool isConfirmed,
      bool isMonetary, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              isMonetary ? '\$$value' : value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.getTextColor(context),
              ),
            ),
          ),
          SizedBox(width: 4.0),
          Icon(
            isConfirmed
                ? CupertinoIcons.checkmark_alt_circle
                : CupertinoIcons.clock,
            color: isConfirmed ? Colors.green : Colors.lightBlue,
            size: 25.0,
          ),
        ],
      ),
    );
  }
}
