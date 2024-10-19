// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthController on AuthControllerBase, Store {
  Computed<String?>? _$tokenComputed;

  @override
  String? get token => (_$tokenComputed ??= Computed<String?>(() => super.token,
          name: 'AuthControllerBase.token'))
      .value;
  Computed<String?>? _$userIdComputed;

  @override
  String? get userId =>
      (_$userIdComputed ??= Computed<String?>(() => super.userId,
              name: 'AuthControllerBase.userId'))
          .value;

  late final _$_tokenAtom =
      Atom(name: 'AuthControllerBase._token', context: context);

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
      Atom(name: 'AuthControllerBase._expiryDate', context: context);

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
      Atom(name: 'AuthControllerBase._userId', context: context);

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
      Atom(name: 'AuthControllerBase.isAuth', context: context);

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

  late final _$stateAtom =
      Atom(name: 'AuthControllerBase.state', context: context);

  @override
  AuthState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AuthState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$authenticateAsyncAction =
      AsyncAction('AuthControllerBase.authenticate', context: context);

  @override
  Future<UserResponse> authenticate(AuthRequest request, bool isLogin) {
    return _$authenticateAsyncAction
        .run(() => super.authenticate(request, isLogin));
  }

  late final _$logoutAsyncAction =
      AsyncAction('AuthControllerBase.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$autoLogoutAsyncAction =
      AsyncAction('AuthControllerBase.autoLogout', context: context);

  @override
  Future<void> autoLogout() {
    return _$autoLogoutAsyncAction.run(() => super.autoLogout());
  }

  late final _$tryAutoLoginAsyncAction =
      AsyncAction('AuthControllerBase.tryAutoLogin', context: context);

  @override
  Future<void> tryAutoLogin() {
    return _$tryAutoLoginAsyncAction.run(() => super.tryAutoLogin());
  }

  @override
  String toString() {
    return '''
isAuth: ${isAuth},
state: ${state},
token: ${token},
userId: ${userId}
    ''';
  }
}
