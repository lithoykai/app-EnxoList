import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@injectable
class HttpClientApp {
  final Dio _dio;

  HttpClientApp({required Dio dio}) : _dio = dio;

  Future<Response> login(AuthRequest request) async {
    try {
      var response = await _dio.post(Endpoints.login, data: request.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> register(AuthRequest request) async {
    try {
      return await _dio.post(Endpoints.register,
          data: jsonEncode(request.toJson()));
    } catch (e) {
      rethrow;
    }
  }

  Future<String> token() async {
    UserResponse? user;
    if (Hive.isBoxOpen('userData')) {
      var box = Hive.box('userData');
      user = box.get('userData');
    }
    String token = user!.token;
    return token;
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['authorization'] = await token();
    return _dio.post(endpoint, data: jsonEncode(data));
  }

  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['authorization'] = await token();
    return _dio.put(endpoint, data: jsonEncode(data));
  }

  Future<Response> delete(String endpoint) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['authorization'] = await token();
    return _dio.delete(endpoint);
  }

  Future<Response> getMethod(String endpoint) async {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['authorization'] = await token();
    return _dio.get(endpoint);
  }
}
