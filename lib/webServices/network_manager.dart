import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();

  factory NetworkManager() => _instance;

  NetworkManager._internal();

  String _baseURL() {
    String server = 'appquesalebackend-production.up.railway.app/que_sale';
    // String server = '127.0.0.1:8000/que_sale';
    String httpProtocol = 'https';

    return '$httpProtocol://$server';
  }

  String _endpoint(EndPoint endPoint) {
    return '${_baseURL()}/${endPoint.path}';
  }

  String mapToQueryParams(Map<String, dynamic> params) {
    return params.entries
        .map((entry) =>
            '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');
  }

  Future<Map<String, dynamic>> requestWith<T>({
    required EndPoint endPoint,
    required HTTPMethod method,
    Map<String, dynamic> params = const {},
    Map<String, String>? headers,
    Map<String, dynamic> body = const {},
  }) async {
    var finalEndPoint = _endpoint(endPoint);
    if (params.isNotEmpty) {
      finalEndPoint = '$finalEndPoint/?${mapToQueryParams(params)}';
    }
    final Uri url = Uri.parse(finalEndPoint);
    http.Response response;
    print("FETCHING ${finalEndPoint}");
    headers ??= {};

    switch (method) {
      case HTTPMethod.get:
        response = await http.get(url, headers: headers);
        break;
      case HTTPMethod.post:
        final effectiveHeaders = Map<String, String>.from(headers);
        effectiveHeaders['Content-Type'] = "application/json";
        response = await http.post(url,
            headers: effectiveHeaders, body: jsonEncode(body));
        break;
      default:
        throw Exception('Método HTTP no soportado');
    }
    try {
      final processedResponse = _processResponse(response);
      return processedResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> _processResponse(http.Response response) async {
    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("RESPONSE DATA ===== $responseData");
        return responseData;
      } catch (e) {
        throw Exception(e);
      }
    } else {
      print("ERROR DE DECODING");
      throw _handleError(response);
    }
  }

  Exception _handleError(http.Response response) {
    switch (response.statusCode) {
      case 400:
        return Exception('Error 400: ${response.body}');
      case 404:
        return Exception('Error 404: No encontrado');
      case 500:
        return Exception('Error 500: Error del servidor');
      default:
        return Exception('Error desconocido: ${response.statusCode}');
    }
  }
}

enum HTTPMethod {
  get,
  post,
}

enum EndPoint {
  //auth
  login,
  register,
  //user
  userData,
  userEvents,
  //events,
  publicEvents,
  createEvent,
  setFavourite,
  eventDetail,
}

extension EndPointExtension on EndPoint {
  String get path {
    switch (this) {
      case EndPoint.login:
        return 'auth/login';
      case EndPoint.register:
        return 'auth/register';
      case EndPoint.userData:
        return 'user/info';
      case EndPoint.userEvents:
        return 'user/events';
      case EndPoint.publicEvents:
        return 'event/public';
      case EndPoint.createEvent:
        return 'event/create';
      case EndPoint.setFavourite:
        return 'event/favourite';
      case EndPoint.eventDetail:
        return 'event/detail';
    }
  }
}
