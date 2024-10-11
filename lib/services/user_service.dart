import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:proyecto_programovil_g3/models/user.dart';

class UserService {
  // Método para cargar el archivo JSON desde assets y retornar una lista de usuarios
  Future<List<Usuario>> fetchUsuarios() async {
    final String response =
        await rootBundle.loadString('assets/data/users.json');
    final List<dynamic> data = json.decode(response);

    // Convertir la lista dinámica de mapas en una lista de instancias de Usuario
    List<Usuario> usuarios = data.map((user) => Usuario.fromMap(user)).toList();

    return usuarios;
  }

  // Método para encontrar un usuario por correo y password
  Future<Usuario?> login(String email, String password) async {
    List<Usuario> usuarios = await fetchUsuarios();

    // Buscar si hay un usuario con el correo y la contraseña proporcionados
    try {
      return usuarios.firstWhere(
          (user) => user.correo == email && user.password == password);
    } catch (e) {
      return null; // Retorna null si no encuentra un usuario que coincida
    }
  }
}
