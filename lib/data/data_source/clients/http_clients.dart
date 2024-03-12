import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/remote_config/remote_config.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@injectable
class HttpClientApp {
  final Dio _dio;
  final RemoteConfig _remoteConfig;

  HttpClientApp({required Dio dio, required RemoteConfig remoteConfig})
      : _dio = dio,
        _remoteConfig = remoteConfig;

  Future<Response> login(AuthRequest request) async {
    try {
      final _endpoint = _remoteConfig.returnEndpoint();
      var response = await _dio.post('$_endpoint/${Endpoints.login}',
          data: request.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> register(AuthRequest request) async {
    final _endpoint = _remoteConfig.returnEndpoint();
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
    final _endpoint = _remoteConfig.returnEndpoint();
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['authorization'] = await token();
    return _dio.post('$_endpoint/$endpoint', data: jsonEncode(data));
  }

  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    final _endpoint = _remoteConfig.returnEndpoint();
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['authorization'] = await token();
    return _dio.put('$_endpoint/$endpoint', data: jsonEncode(data));
  }

  Future<Response> delete(String endpoint) async {
    final _endpoint = _remoteConfig.returnEndpoint();
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['authorization'] = await token();
    return _dio.delete('$_endpoint/$endpoint');
  }

  Future<Response> getMethod(String endpoint) async {
    final _endpoint = _remoteConfig.returnEndpoint();
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['authorization'] = await token();
    return _dio.get('$_endpoint/$endpoint');
  }
}
