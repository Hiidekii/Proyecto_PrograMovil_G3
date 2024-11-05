class EventCategorySubItem {
  final int id;
  final String userName;
  final String userThumbnail;
  final double amount;
  final bool confirmed;

  EventCategorySubItem(
      {required this.id,
      required this.userName,
      required this.userThumbnail,
      required this.amount,
      required this.confirmed});

  // Método para decodificar el JSON
  factory EventCategorySubItem.fromJson(Map<String, dynamic> json) {
    print("==DESDE CATEGORY SUB ITEM  ${json}");
    return EventCategorySubItem(
        id: json['id'],
        userName: json['userName'],
        userThumbnail: json['userThumbnail'],
        amount: json['amount'],
        confirmed: json['status']);
  }
}
