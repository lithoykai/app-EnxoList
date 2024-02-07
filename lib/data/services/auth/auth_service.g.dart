// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthService on AuthServiceBase, Store {
  Computed<String?>? _$tokenComputed;

  @override
  String? get token => (_$tokenComputed ??=
          Computed<String?>(() => super.token, name: 'AuthServiceBase.token'))
      .value;
  Computed<String?>? _$userIdComputed;

  @override
  String? get userId => (_$userIdComputed ??=
          Computed<String?>(() => super.userId, name: 'AuthServiceBase.userId'))
      .value;

  late final _$_tokenAtom =
      Atom(name: 'AuthServiceBase._token', context: context);

  @override
  String? get _token {
    _$_tokenAtom.reportRead();
    return super._token;
  }

  @override
  set _token(String? value) {
    _$_tokenAtom.reportWrite(value, super._token, () {
      super._token = value;
    });
  }

  late final _$_expiryDateAtom =
      Atom(name: 'AuthServiceBase._expiryDate', context: context);

  @override
  DateTime? get _expiryDate {
    _$_expiryDateAtom.reportRead();
    return super._expiryDate;
  }

  @override
  set _expiryDate(DateTime? value) {
    _$_expiryDateAtom.reportWrite(value, super._expiryDate, () {
      super._expiryDate = value;
    });
  }

  late final _$_userIdAtom =
      Atom(name: 'AuthServiceBase._userId', context: context);

  @override
  String? get _userId {
    _$_userIdAtom.reportRead();
    return super._userId;
  }

  @override
  set _userId(String? value) {
    _$_userIdAtom.reportWrite(value, super._userId, () {
      super._userId = value;
    });
  }

  late final _$isAuthAtom =
      Atom(name: 'AuthServiceBase.isAuth', context: context);

  @override
  bool get isAuth {
    _$isAuthAtom.reportRead();
    return super.isAuth;
  }

  @override
  set isAuth(bool value) {
    _$isAuthAtom.reportWrite(value, super.isAuth, () {
      super.isAuth = value;
    });
  }

  late final _$authenticateAsyncAction =
      AsyncAction('AuthServiceBase.authenticate', context: context);

  @override
  Future<Either<AuthException, UserResponse>> authenticate(
      AuthRequest request) {
    return _$authenticateAsyncAction.run(() => super.authenticate(request));
  }

  late final _$logoutAsyncAction =
      AsyncAction('AuthServiceBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$tryAutoLoginAsyncAction =
      AsyncAction('AuthServiceBase.tryAutoLogin', context: context);

  @override
  Future<void> tryAutoLogin() {
    return _$tryAutoLoginAsyncAction.run(() => super.tryAutoLogin());
  }

  late final _$AuthServiceBaseActionController =
      ActionController(name: 'AuthServiceBase', context: context);

  @override
  void clearLogoutTimer() {
    final _$actionInfo = _$AuthServiceBaseActionController.startAction(
        name: 'AuthServiceBase.clearLogoutTimer');
    try {
      return super.clearLogoutTimer();
    } finally {
      _$AuthServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void autoLogout() {
    final _$actionInfo = _$AuthServiceBaseActionController.startAction(
        name: 'AuthServiceBase.autoLogout');
    try {
      return super.autoLogout();
    } finally {
      _$AuthServiceBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isAuth: ${isAuth},
token: ${token},
userId: ${userId}
    ''';
  }
}
