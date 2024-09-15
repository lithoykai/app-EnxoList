import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/clients/http_client.dart';
import 'package:enxolist/data/data_source/remote_config/remote_config.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HttpClientApp)
class HttpClientAppMock implements HttpClientApp {
  final Dio _dio;

  HttpClientAppMock({required Dio dio, required RemoteConfig remoteConfig})
      : _dio = dio;

  Future<Response> _authorizedRequest(
      Future<Response> Function() request) async {
    final token = await _getToken();
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['authorization'] = token;
    return request();
  }

  Future<String> _getToken() async {
    if (Hive.isBoxOpen('userData')) {
      final box = Hive.box('userData');
      final user = box.get('userData') as UserResponse?;
      if (user != null) {
        return user.token;
      }
    }
    throw Exception('Token not found');
  }

  @override
  Future<Response> login(AuthRequest request) async {
    try {
      const _endpoint = "http://192.168.0.115:8080";
      var response =
          await _dio.post('$_endpoint/auth/login', data: request.toJson());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> register(AuthRequest request) async {
    const _endpoint = "http://192.168.0.115:8080";
    try {
      return await _dio.post("$_endpoint/auth/register",
          data: jsonEncode(request.toJson()));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    const _endpoint = "http://192.168.0.115:8080";
    return _authorizedRequest(() async {
      return _dio.post('$_endpoint/$endpoint', data: jsonEncode(data));
    });
  }

  @override
  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    return _authorizedRequest(() async {
      const _endpoint = "http://192.168.0.115:8080";
      return _dio.put('$_endpoint/$endpoint', data: jsonEncode(data));
    });
  }

  @override
  Future<Response> delete(String endpoint) async {
    return _authorizedRequest(() async {
      const _endpoint = "http://192.168.0.115:8080";
      return _dio.delete('$_endpoint/$endpoint');
    });
  }

  @override
  Future<Response> getMethod(String endpoint) async {
    const _endpoint = "http://192.168.0.115:8080";
    return _authorizedRequest(() async {
      return _dio.get('$_endpoint/$endpoint');
    });
  }
}
