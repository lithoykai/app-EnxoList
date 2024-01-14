import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/data/services/auth_service.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/domain/entities/product/user.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class HttpClientApp {
  final Dio _dio;

  HttpClientApp({required Dio dio}) : _dio = dio;

  Future<Response> login(String endpoint, AuthRequest request) {
    return _dio.post(endpoint, data: jsonEncode(request.toJson()));
  }

  Future<Response> register(String endpoint, AuthRequest request) {
    return _dio.post(endpoint, data: jsonEncode(request.toJson()));
  }

  Future<Response> getMethod(String endpoint) {
    User user = User(email: 'admin2@teste.com');
    final token = getIt<AuthService>().token;

    debugPrint('$token');
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['authorization'] = 'Barear ${token}';
    return _dio.get(endpoint);
  }

  Future<Response> getTokenLogin(
      User user, String password, String endpoint) async {
    final response = await _dio.post(endpoint,
        data: jsonEncode({
          'email': user.email,
          'password': password,
        }));
    final bodyToken = jsonDecode(response.data);

    print(bodyToken);
    return bodyToken['token'];
  }
}
