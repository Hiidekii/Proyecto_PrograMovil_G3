class Usuario {
  int idUsuario;
  String nombreUsuario;
  String correo;
  String password;

  Usuario({
    required this.idUsuario,
    required this.nombreUsuario,
    required this.correo,
    required this.password,
  });

  // Método toString para representar la clase como un String
  @override
  String toString() {
    return 'Usuario{idUsuario: $idUsuario, nombreUsuario: $nombreUsuario, correo: $correo, password: $password}';
  }

  // Método para convertir la instancia a un Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'idUsuario': idUsuario,
      'nombreUsuario': nombreUsuario,
      'correo': correo,
      'password': password,
    };
  }

  // Método para crear una instancia de Usuario a partir de un Map
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['idUsuario'],
      nombreUsuario: map['nombreUsuario'],
      correo: map['correo'],
      password: map['password'],
    );
  }
}
