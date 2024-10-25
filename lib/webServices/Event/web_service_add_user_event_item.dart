import 'package:get_storage/get_storage.dart';
import 'package:proyecto_programovil_g3/models/Auth/check_response.dart';
import 'package:proyecto_programovil_g3/models/base_response.dart';
import 'package:proyecto_programovil_g3/webServices/network_manager.dart';
import 'package:proyecto_programovil_g3/webServices/web_service_protocol.dart';

class WebServiceAddUserEventItem implements WebServiceProtocol {
  final GetStorage storage = GetStorage();
  @override
  EndPoint get endPoint => EndPoint.setUserItem;
  @override
  HTTPMethod get httpMethod => HTTPMethod.get;

  Future<BaseResponse<CheckResponse>> fetchData(
      int itemID, double amount) async {
    final token = storage.read('token') ?? "";
    final headers = {
      'Authorization': 'Token $token',
    };
    final params = {
      'id': itemID,
      'amount': amount,
    };
    try {
      final response = await NetworkManager().requestWith(
        endPoint: endPoint,
        method: httpMethod,
        headers: headers,
        params: params,
      );
      print("USER DATA $response");
      return BaseResponse.fromJson(
          response, (json) => CheckResponse.fromJson(json));
    } catch (error) {
      throw Exception('Error al traer los eventos del usuario: $error');
    }
  }
}
