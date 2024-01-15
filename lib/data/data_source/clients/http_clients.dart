import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/infra/utils/store.dart';
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

  Future<Response> getMethod(String endpoint) async {
    final token = await Store.getString('token');
    print('TOKEN GETMETHOD: $token');
    debugPrint('$token');
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['authorization'] = '${token}';
    return _dio.get(endpoint);
  }

  // Future<Response> getTokenLogin(
  //     User user, String password, String endpoint) async {
  //   final response = await _dio.post(endpoint,
  //       data: jsonEncode({
  //         'email': user.email,
  //         'password': password,
  //       }));
  //   final bodyToken = jsonDecode(response.data);

  //   print(bodyToken);
  //   return bodyToken['token'];
  // }
}
