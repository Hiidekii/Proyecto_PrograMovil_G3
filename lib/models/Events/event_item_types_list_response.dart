import 'package:proyecto_programovil_g3/models/Events/event_category_response.dart';

class EventItemTypesListResponse {
  final List<CategoryResponse> categories;

  EventItemTypesListResponse({
    required this.categories,
  });

  // Método para decodificar el JSON
  factory EventItemTypesListResponse.fromJson(List<dynamic> json) {
    print("DESDE LIST  XD${json}");
    return EventItemTypesListResponse(
      categories: json
          .map((category) =>
              CategoryResponse.fromJson(category as Map<String, dynamic>))
          .toList(),
    );
  }
}
