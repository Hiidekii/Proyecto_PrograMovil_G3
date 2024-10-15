import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:proyecto_programovil_g3/models/base_response.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();

  factory NetworkManager() => _instance;

  NetworkManager._internal();

  String _baseURL() {
    String server = 'appquesalebackend-production.up.railway.app/que_sale';
    String httpProtocol = 'https';

    return '$httpProtocol://$server';
  }

  String _endpoint(EndPoint endPoint) {
    return '${_baseURL()}/${endPoint.path}';
  }

  Future<Map<String, dynamic>> requestWith<T>({
    required EndPoint endPoint,
    required HTTPMethod method,
    Map<String, dynamic> params = const {},
    Map<String, String>? headers,
    Map<String, dynamic> body = const {},
  }) async {
    final Uri url = Uri.parse(_endpoint(endPoint));
    http.Response response;

    headers ??= {};
    // 20211918@aloe.ulima.edu.pe
    switch (method) {
      case HTTPMethod.get:
        print("HEADEARSSSSSSS======== $headers");
        response = await http.get(url, headers: headers);
        break;
      case HTTPMethod.post:
        final effectiveHeaders = Map<String, String>.from(headers);
        effectiveHeaders['Content-Type'] = "application/json";
        print("Headers: $effectiveHeaders , $body");
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
  login,
  register,
  userData,
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
    }
  }
}
