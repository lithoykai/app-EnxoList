import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:enxolist/infra/utils/store.dart';
import 'package:injectable/injectable.dart';

@injectable
class HttpClientApp {
  final Dio _dio;

  HttpClientApp({required Dio dio}) : _dio = dio;

  Future<Response> login(AuthRequest request) {
    print(jsonEncode(request.toJson()));
    return _dio.post(Endpoints.login, data: jsonEncode(request.toJson()));
  }

  Future<Response> register(String endpoint, AuthRequest request) {
    return _dio.post(endpoint, data: jsonEncode(request.toJson()));
  }

  Future<Response> getMethod(String endpoint) async {
    final userData = await StoreData.getMap('userData');
    String token = userData['token'];
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['authorization'] = token;
    return _dio.get(endpoint);
  }
}
