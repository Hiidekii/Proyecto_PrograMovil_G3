import 'package:proyecto_programovil_g3/models/user.dart';

class UserService {
  Future<User?> login(String user, String password) async {
    bool valid = false;
    if (user == 'admin' && password == '123') {
      return User(idUsuario: 10, correo: 'hideki@gmail.com');
    }
    return null;
  }
}
