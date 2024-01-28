import 'dart:async';

import 'package:enxolist/data/data_source/clients/http_clients.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:enxolist/infra/failure/auth_exception.dart';
import 'package:enxolist/infra/utils/store.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'auth_service.g.dart';

@lazySingleton
class AuthService = AuthServiceBase with _$AuthService;

abstract class AuthServiceBase with Store {
  final HttpClientApp _http;
  @observable
  String? _token;
  @observable
  DateTime? _expiryDate;
  Timer? _logoutTimer;
  @observable
  String? _userId;

  AuthServiceBase({required HttpClientApp http}) : _http = http;

  @observable
  bool isAuth = false;

  void updateAuthStatus(bool value) {
    isAuth = value;
  }

  @computed
  String? get token {
    return isAuth ? _token : null;
  }

  @computed
  String? get userId {
    return isAuth ? _userId : null;
  }

  @action
  Future<void> authenticate(AuthRequest request) async {
    try {
      if (request.name == null) {
        final response = await _http.login(Endpoints.login, request);
        if (response.statusCode != 200) {
          throw AuthException(response.data['detail']);
        }
        Map<String, dynamic> data = response.data;
        UserResponse user = UserResponse.fromJson(data);
        user.token = data['token'];
        _token = user.token;
        _userId = user.id;
        _expiryDate = DateTime.now().add(Duration(
          hours: data['expiryDate'],
        ));
        await StoreData.saveMap('userData', {
          'token': _token,
          'email': user.email,
          'userId': user.id,
          'expiryToken': _expiryDate!.toIso8601String(),
        });
        final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
        print(_token != null && isValid);
        updateAuthStatus(_token != null && isValid);
      } else {
        final response = await _http.register(Endpoints.register, request);
        Map<String, dynamic> data = response.data;
        UserResponse user = UserResponse.fromJson(data);
        user.token = data['token'];
        _token = user.token;
        _userId = user.id;
        _expiryDate = DateTime.now().add(Duration(
          hours: data['expiryDate'],
        ));
        await StoreData.saveMap('userData', {
          'token': _token,
          'email': user.email,
          'userId': user.id,
          'expiryToken': _expiryDate!.toIso8601String(),
        });
        final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
        updateAuthStatus(_token != null && isValid);
      }
    } catch (e) {
      rethrow;
    }
  }

  @action
  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    clearLogoutTimer();
    StoreData.remove('userData');
    updateAuthStatus(false);
  }

  @action
  void clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  @action
  void autoLogout() {
    clearLogoutTimer();
    final _timeToLogout = _expiryDate?.difference(DateTime.now()).inHours;
    _logoutTimer = Timer(
      Duration(
        hours: _timeToLogout ?? 0,
      ),
      logout,
    );
  }

  @action
  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await StoreData.getMap('userData');
    if (userData.isEmpty) return;

    final expiryDate = DateTime.parse(userData['expiryToken']);
    if (expiryDate.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _userId = userData['userId'];
    _expiryDate = expiryDate;

    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;

    updateAuthStatus(_token != null && isValid);
  } // @action
  // Future<void> tryAutoLogin() async {
  //   if (isAuth) return;

  //   final userData = await StoreData.getMap('userData');
  //   if (userData.isEmpty) return;

  //   final expiryDate = DateTime.parse(userData['expiryToken']);
  //   if (expiryDate.isBefore(DateTime.now())) return;

  //   _token = userData['token'];
  //   _userId = userData['userId'];
  //   _expiryDate = expiryDate;

  //   autoLogout();
  // }
}
