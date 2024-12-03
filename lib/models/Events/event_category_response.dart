import 'package:proyecto_programovil_g3/models/Events/event_category_item_response.dart';

enum EventCategoryType {
  trago,
  chancha,
  jama,
}

class CategoryResponse {
  final int id;
  final String type;
  final bool floatable;
  final List<EventCategoryItem>? items;
  CategoryResponse(
      {required this.id,
      required this.type,
      required this.floatable,
      this.items});

  // Método para decodificar el JSON
  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    print("DESDE CATEGORY ITEM  ${json}");
    return CategoryResponse(
      id: json['id'],
      type: json['type'],
      floatable: json['floatable'],
      items: ((json['items'] as List<dynamic>?) ?? [])
          .map((item) => EventCategoryItem.fromJson(item))
          .toList(),
    );
  }

  EventCategoryType? get categoryType {
    switch (type.toLowerCase()) {
      case 'la jama':
        return EventCategoryType.jama;
      case 'el trago':
        return EventCategoryType.trago;
      case 'la chancha':
        return EventCategoryType.chancha;
      default:
        return null;
    }
  }
}
