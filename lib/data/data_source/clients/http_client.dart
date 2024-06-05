import 'package:dio/dio.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/di/injectable.dart';

import './http_clients_mock.dart';

abstract class HttpClientApp {
  Future<Response> login(AuthRequest request);

  Future<Response> register(AuthRequest request);

  Future<Response> post(String endpoint, Map<String, dynamic> data);

  Future<Response> put(String endpoint, Map<String, dynamic> data);

  Future<Response> delete(String endpoint);

  Future<Response> getMethod(String endpoint);

  factory HttpClientApp() => getIt<HttpClientAppMock>();
}
