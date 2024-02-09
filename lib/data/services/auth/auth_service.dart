import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/clients/http_clients.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:enxolist/infra/failure/auth_exception.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'auth_service.g.dart';

@lazySingleton
@injectable
class AuthService = AuthServiceBase with _$AuthService;

abstract class AuthServiceBase with Store {
  late Box _userBox;
  @observable
  String? _token;
  @observable
  DateTime? _expiryDate;
  Timer? _logoutTimer;
  @observable
  String? _userId;

  final HiveInterface _hive;
  final HttpClientApp _http;
  AuthServiceBase({required HttpClientApp http, required HiveInterface hive})
      : _http = http,
        _hive = hive;

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

  Future<void> _openBoxIfNeeded() async {
    if (!_hive.isBoxOpen('userData')) {
      _userBox = await _hive.openBox('userData');
    }
  }

  Future<UserResponse> saveAuthenticate(Response<dynamic> response) async {
    await _openBoxIfNeeded();

    // final _userBox; = await _hive.openLazyBox('userData');

    await _userBox.clear();
    Map<String, dynamic> data = response.data;
    UserResponse user = UserResponse.fromJson(data);
    await _userBox.put('userData', user);
    _token = user.token;
    _userId = user.id;
    _expiryDate = user.expiryDate;

    return user;
  }

  @action
  Future<Either<AuthException, UserResponse>> authenticate(
      AuthRequest request) async {
    try {
      if (request.name == null) {
        final response = await _http.login(request);
        if (response.statusCode != 200) {
          throw AuthException(response.data['detail']);
        }
        final user = await saveAuthenticate(response);
        final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;

        updateAuthStatus(_token != null && isValid);

        return right(user);
      } else {
        final response = await _http.register(Endpoints.register, request);
        final user = await saveAuthenticate(response);
        final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
        updateAuthStatus(_token != null && isValid);
        return right(user);
      }
    } catch (e) {
      throw left(AuthException(e.toString()));
    }
  }

  @action
  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    clearLogoutTimer();
    await _openBoxIfNeeded();

    await _userBox.clear();
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
    await _openBoxIfNeeded();

    if (isAuth) return;

    UserResponse? user = await _userBox.get('userData');
    print(user!.id);
    if (user == null) return;

    if (user.expiryDate.isBefore(DateTime.now())) return;

    _token = user.token;
    _userId = user.id;
    _expiryDate = user.expiryDate;

    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    updateAuthStatus(_token != null && isValid);
  }

// @action
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
