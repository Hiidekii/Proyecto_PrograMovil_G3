class CheckResponse {
  final String? message;
  final String? error;

  CheckResponse({this.message, this.error});

  factory CheckResponse.fromJson(Map<String, dynamic> json) {
    return CheckResponse(
      message: json['message'] as String?,
      error: json['error'] as String?,
    );
  }
}
