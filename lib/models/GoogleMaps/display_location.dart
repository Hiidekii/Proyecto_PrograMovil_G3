class DisplayName {
  final String text;
  final String? languageCode;

  DisplayName({
    required this.text,
    required this.languageCode,
  });

  // Factory method para crear una instancia de 'DisplayName' desde un mapa JSON
  factory DisplayName.fromJson(Map<String, dynamic> json) {
    return DisplayName(
      text: json['text'],
      languageCode: json['languageCode'] as String?,
    );
  }
  // Método para convertir una instancia de 'DisplayName' a JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'languageCode': languageCode,
    };
  }
}
