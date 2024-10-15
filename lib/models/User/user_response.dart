import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class User {
  String username;
  String email;
  String thumbnail;

  User({
    required this.username,
    required this.email,
    required this.thumbnail,
  });

  @override
  String toString() {
    return 'Usuario{nombreUsuario: $username, correo: $email, thumbnail: $thumbnail}';
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'thumbnail': thumbnail,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      thumbnail: json['thumbnail'],
    );
  }
}
