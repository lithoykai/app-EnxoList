import 'package:enxolist/data/data_source/clients/http_clients.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:enxolist/infra/utils/store.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthService {
  String? _token;
  String? get token => _token;

  bool get isAuth {
    return _token != null;
  }

  final HttpClientApp _http;

  AuthService({required HttpClientApp http}) : _http = http;

  Future<void> tryAutoLogin() async {
    if (isAuth) return;
    final userData = await Store.getString('token');
    _token = userData;
  }

  Future<void> authenticate(AuthRequest request) async {
    try {
      if (request.name == null) {
        final response = await _http.login(Endpoints.login, request);
        _token = response.data['token'];
        await Store.saveString('token', token as String);
        print(_token);
        final getProducts = await _http.getMethod(Endpoints.getProducts);
        print(getProducts.data);
      } else {
        final response = await _http.register(Endpoints.register, request);
      }
    } catch (e) {
      rethrow;
    }
  }
}
