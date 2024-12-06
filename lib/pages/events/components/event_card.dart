import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/components/q_sale_image.dart';
import 'package:proyecto_programovil_g3/pages/events/new_event.dart/new_event_page.dart';
import 'package:proyecto_programovil_g3/pages/events/new_event.dart/new_event_view_model.dart';
import 'package:proyecto_programovil_g3/webServices/Event/web_service_event_detail.dart';
import 'package:proyecto_programovil_g3/models/Events/event_response.dart';

class EventCard extends StatefulWidget {

  final String title;
  final String date;
  final String time;
  final String imageUrl;
  final VoidCallback? onEdit;
  final VoidCallback? onShare;
  final VoidCallback? onManage;
  final bool isEditable;
  final bool isFavorite;
  final VoidCallback? onTap;
  final int eventId;  // Nuevo campo para el ID del evento
  final EventDataResponse event;

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
    this.onTap,
    required this.eventId,
    required this.event,
  }) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  
  bool showDetails = false;
  final WebServiceEventDetail _webService = WebServiceEventDetail();
  EventDataResponse? eventDetails;
  bool isLoading = false;

  Future<void> loadEventDetails() async {
    if (!showDetails || eventDetails != null) return;
    
    setState(() {
      isLoading = true;
    });

    try {
      final response = await _webService.fetchData(widget.eventId);
      if (response.success) {
        setState(() {
          eventDetails = response.data;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error loading event details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

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
        child: Padding(
          padding: EdgeInsets.only(
            left: 0.0,
            right: 25.0,
            top: 0.0,
            bottom: 01.0,
          ),
          child: ListTile(
            title: Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: showDetails
                ? ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: _buildItemDetails(context),
                  )
                : Container(
                    height: 50.0,
                    child: Text(
                      '${widget.date} - ${widget.time}',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
            onTap: widget.onTap,
          ),
        ),
      ),
    );
  }

  Widget _buildItemDetails(BuildContext context) {
    if (isLoading) {
      return Container(
        height: 50.0,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (eventDetails == null) {
      // Cargar detalles si aún no están cargados
      loadEventDetails();
      return Container(
        height: 50.0,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      height: 50.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...eventDetails!.lista.expand((category) {
              return category.items!.map((item) =>
                Row(
                  children: [
                    _buildItemInfo(
                      category.type,
                      item.totalAmount.toString(),
                      item.items.isNotEmpty,  // Consideramos que hay confirmación si hay items
                      category.floatable,
                      context,
                    ),
                    SizedBox(width: 10.0),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemInfo(String label, String value, bool isConfirmed,
      bool isMonetary, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
      margin: EdgeInsets.symmetric(vertical: 3.0),
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

  Widget _buildImage() {
    return Positioned(
      left: 4,
      top: 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          height: 95,
          width: 83,
          child: QSaleImage(
            imgUrlString: widget.imageUrl,
            width: 83,
            height: 95,
            imgScale: BoxFit.cover,
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
            widget.isEditable
                ? CupertinoIcons.pencil
                : (widget.isFavorite
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.heart),
            widget.isEditable ? widget.onEdit : widget.onShare,
          ),
          SizedBox(height: 6),
          _buildActionButton(
            context,
            Icons.checklist,
            () {
              setState(() {
                showDetails = !showDetails;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, VoidCallback? onPressed) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.getTextColor(context)),
        onPressed: () {
          if (icon == CupertinoIcons.pencil) {
            _showEditModal(context);
          } else {
            onPressed?.call();
          }
        },
        padding: EdgeInsets.zero,
      ),
    );
  }
  void _showEditModal(BuildContext context) {
    final viewModel = Get.put(NewEventViewModel());
    viewModel.loadEventForEditing(widget.event);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return const NewEventPage();
      },
    );
  }
  
}
