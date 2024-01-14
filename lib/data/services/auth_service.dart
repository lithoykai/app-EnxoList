import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/clients/http_clients.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:enxolist/infra/utils/store.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthService {
  String? token;

  final HttpClientApp _http;

  AuthService({required HttpClientApp http}) : _http = http;

  Future<bool> authenticate(AuthRequest request) async {
    try {
      if (request.name == null) {
        final response = await _http.login(Endpoints.login, request);
        token = response.data['token'];
        Store.saveString('token', token as String);
        GetIt.I.registerLazySingleton<AuthService>(
            () => AuthService(http: HttpClientApp(dio: Dio())));
      } else {
        final response = await _http.register(Endpoints.register, request);
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }
}
