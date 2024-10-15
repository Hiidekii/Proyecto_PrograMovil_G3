class RegisterResponse {
  final String? message;
  final String? error;

  RegisterResponse({this.message, this.error});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      message: json['message'] as String?,
      error: json['error'] as String?,
    );
  }
}
