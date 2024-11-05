class BaseResponse<T> {
  final bool success;
  final dynamic data;
  BaseResponse({required this.success, required this.data});

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    Function(dynamic) fromJsonT,
  ) {
    return BaseResponse(
      success: json['success'],
      data: fromJsonT(json['data']),
    );
  }
}
