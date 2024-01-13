import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enxolist/domain/entities/product/user.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class HttpClientApp {
  final Dio _dio;

  HttpClientApp({required Dio dio}) : _dio = dio;

  Future<Response> getMethod(String endpoint) {
    User user = User(email: 'admin2@teste.com', password: 'teste123');
    final token = getTokenLogin(user, Endpoints.login);

    debugPrint('$token');
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['authorization'] = 'Barear ${token}';
    return _dio.get(endpoint);
  }

  Future<Response> getTokenLogin(User user, String endpoint) async {
    final response = await _dio.post(endpoint,
        data: jsonEncode({
          'email': user.email,
          'password': user.password,
        }));
    final bodyToken = jsonDecode(response.data);

    print(bodyToken);
    return bodyToken['token'];
  }
}
