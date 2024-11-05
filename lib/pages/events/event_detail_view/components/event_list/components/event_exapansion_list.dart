import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_programovil_g3/configs/colors.dart';
import 'package:proyecto_programovil_g3/models/Events/event_category_item_response.dart';
import 'package:proyecto_programovil_g3/models/Events/event_category_response.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_list/components/event_list_item.dart';
import 'package:proyecto_programovil_g3/pages/events/event_detail_view/components/event_list/components/event_list_money.dart';

class EventExapansionList extends StatefulWidget {
  final List<EventCategoryItem> categoryItems;
  final EventCategoryType categoryType;
  final void Function(int, double) aportarFunct;
  final bool isEditable;

  const EventExapansionList({
    Key? key,
    required this.categoryItems,
    required this.categoryType,
    required this.aportarFunct,
    required this.isEditable,
  }) : super(key: key);

  @override
  _EventExapansionListState createState() => _EventExapansionListState();
}

class _EventExapansionListState extends State<EventExapansionList> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.categoryItems.length,
      (index) => TextEditingController(text: widget.categoryItems[index].name),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColors.softBlack,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var index = 0; index < widget.categoryItems.length; index++)
            if (!widget.isEditable)
              Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  collapsedIconColor: Colors.white,
                  iconColor: Colors.white,
                  shape: const Border(),
                  title: Row(
                    children: [
                      Text(
                        widget.categoryItems[index].name,
                        style: const TextStyle(
                          color: AppColors.cream,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              widget.categoryItems[index].currentPercentage == 1
                                  ? Colors.green
                                  : widget.categoryItems[index]
                                              .currentPercentage <
                                          0.5
                                      ? AppColors.red
                                      : AppColors.yellow,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text(
                          '${widget.categoryType == EventCategoryType.chancha ? widget.categoryItems[index].currentAmount : widget.categoryItems[index].currentAmount.toInt()}/${widget.categoryType == EventCategoryType.chancha ? widget.categoryItems[index].totalAmount : widget.categoryItems[index].totalAmount.toInt()}',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  tilePadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  childrenPadding: EdgeInsets.zero,
                  children: [
                    for (var row in widget.categoryItems[index].items)
                      ListItemWidget(
                        name: row.userName,
                        quantity: row.amount,
                        status: row.confirmed ? "Done" : "waiting",
                        userImgUrl: row.userThumbnail,
                        isFloatable:
                            widget.categoryType == EventCategoryType.chancha,
                      ),
                    if (widget.categoryItems[index].currentPercentage != 1)
                      AmountInputWidget(
                        aportarFunct: widget.aportarFunct,
                        itemID: widget.categoryItems[index].id,
                        isFloatable:
                            widget.categoryType == EventCategoryType.chancha,
                        maxAmount: widget.categoryItems[index].totalAmount -
                            widget.categoryItems[index].currentAmount,
                      ),
                    const SizedBox(height: 20)
                  ],
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Ingrese nombre",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Espacio entre el TextField y el botón
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Text(
                      'Eliminar',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
        ],
      ),
    );
  }
}
