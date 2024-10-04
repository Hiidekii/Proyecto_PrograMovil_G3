class User {
  int id;
  String name;
  String email;
  String password;

  User({required this.id, required this.name, required this.email, required this.password});

  // fromMap method to create a User object from a map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
    );
  }

  // toJson method to convert the User object to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // toString method for a readable format of the User object
  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, password: $password}';
  }
}
