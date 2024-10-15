class LoginResponse {
  final String? token;
  final String? error;
  LoginResponse({required this.token, required this.error});

  factory LoginResponse.fromJson(dynamic json) {
    return LoginResponse(
        token: json['token'] as String?, error: json['error'] as String?);
  }
}
