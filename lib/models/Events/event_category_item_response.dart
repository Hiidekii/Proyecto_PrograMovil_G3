import 'package:proyecto_programovil_g3/models/Events/event_category_sub_item_response.dart';

class EventCategoryItem {
  final int id;
  final String name;
  final double totalAmount;
  final List<EventCategorySubItem> items;

  EventCategoryItem(
      {required this.id,
      required this.name,
      required this.totalAmount,
      required this.items});

  // Método para decodificar el JSON
  factory EventCategoryItem.fromJson(Map<String, dynamic> json) {
    print("==DESDE CATEGORY ITEM  ${json}");
    return EventCategoryItem(
      id: json['id'],
      name: json['name'],
      totalAmount: json['total_amount'],
      items: ((json['items'] as List<dynamic>?) ?? [])
          .map((item) => EventCategorySubItem.fromJson(item))
          .toList(),
    );
  }
  double get currentAmount {
    return items.fold(0.0, (sum, item) => sum + item.amount);
  }

  double get currentPercentage {
    return (currentAmount / totalAmount);
  }
}
