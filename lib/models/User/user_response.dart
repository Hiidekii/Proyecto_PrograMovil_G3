class User {
  String username;
  String email;
  String thumbnail;
  String? role;
  String? confirmation;

  User({
    required this.username,
    required this.email,
    required this.thumbnail,
    this.role,
    this.confirmation,
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
      'role': role,
      'confirmation': confirmation,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      thumbnail: json['thumbnail'],
      role: json['role'] as String?,
      confirmation: json['confirmation'] as String?,
    );
  }
  UserRole? get userRole {
    if (role == null) return null;
    switch (role!.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'guest':
        return UserRole.guest;
      default:
        return null;
    }
  }

  ConfirmationStatus? get confirmationStatus {
    if (confirmation == null) return null;

    switch (confirmation!.toLowerCase()) {
      case 'confirmado':
        return ConfirmationStatus.confirmed;
      case 'no asisitirá':
        return ConfirmationStatus.unconfirmed;
      case 'pendiente':
        return ConfirmationStatus.pending;
      default:
        return null;
    }
  }
}

enum UserRole {
  admin,
  guest,
}

enum ConfirmationStatus {
  confirmed,
  unconfirmed,
  pending,
}
