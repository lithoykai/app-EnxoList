import 'dart:async';

import 'package:enxolist/data/data_source/product/product_remote_datasource_offline.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource_online.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource_proxy.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/domain/use-cases/user/acceptCouple_usecase.dart';
import 'package:enxolist/domain/use-cases/user/authenticate_usecase.dart';
import 'package:enxolist/domain/use-cases/user/getCouple_usecase.dart';
import 'package:enxolist/domain/use-cases/user/get_current_user_usecase.dart';
import 'package:enxolist/domain/use-cases/user/logout_usecase.dart';
import 'package:enxolist/domain/use-cases/user/refuseCouple_usecase.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'auth_controller.g.dart';

@singleton
class AuthController = AuthControllerBase with _$AuthController;

abstract class AuthControllerBase with Store {
  final AuthenticateUsecase _authenticateUsecase;
  final AcceptCoupleUseCase _acceptCoupleUseCase;
  final GetCoupleUseCase _getCoupleUseCase;
  final RefuseCoupleUseCase _refuseCoupleUseCase;
  final GetCurrentUserUsecase _getCurrentUserUsecase;
  final LogoutUsecase _logoutUsecase;

  AuthControllerBase({
    required GetCurrentUserUsecase getCurrentUserUsecase,
    required AuthenticateUsecase authenticateUsecase,
    required AcceptCoupleUseCase acceptCoupleUseCase,
    required GetCoupleUseCase getCoupleUseCase,
    required RefuseCoupleUseCase refuseCoupleUseCase,
    required LogoutUsecase logoutUsecase,
  })  : _acceptCoupleUseCase = acceptCoupleUseCase,
        _authenticateUsecase = authenticateUsecase,
        _getCoupleUseCase = getCoupleUseCase,
        _refuseCoupleUseCase = refuseCoupleUseCase,
        _getCurrentUserUsecase = getCurrentUserUsecase,
        _logoutUsecase = logoutUsecase;

  @observable
  String? _token;
  @observable
  DateTime? _expiryDate;
  Timer? _logoutTimer;
  @observable
  String? _userId;
  @observable
  bool isAuth = false;

  @observable
  AuthState state = AuthIdle();

  @action
  Future<UserResponse> authenticate(AuthRequest request, bool isLogin) async {
    try {
      state = AuthLoading();

      final user = await _authenticateUsecase(request, isLogin);

      return user.fold((failure) {
        if (failure is AuthFailure) {
          state = AuthError(failure.msg!);

          return Future.error(failure.msg!);
        } else if (failure is ServerFailure) {
          state = AuthError('Ocorreu um erro no servidor!');
          return Future.error(failure.msg!);
        } else if (failure is AppFailure) {
          state = AuthError(failure.msg!);
          throw AppFailure(msg: failure.msg!);
        } else {
          throw Exception('Erro desconhecido');
        }
      }, (response) {
        saveAuthenticate(response);
        final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
        updateAuthStatus(_token != null && isValid);

        switchDataSource(false);

        return response;
      });
    } on Exception catch (e) {
      state = AuthError('Ocorreu um erro inesperado: $e');
      return Future.error(e);
    } finally {
      state = AuthIdle();
    }
  }

  @computed
  String? get token {
    return isAuth ? _token : null;
  }

  @computed
  String? get userId {
    return isAuth ? _userId : null;
  }

  void saveAuthenticate(UserResponse user) {
    _token = user.token;
    _userId = user.id;
    _expiryDate = user.expiryDate;
  }

  void updateAuthStatus(bool value) {
    isAuth = value;
  }

  @action
  Future<void> logout() async {
    final response = await _logoutUsecase();
    if (response.isRight()) {
      _token = null;
      _userId = null;
      _expiryDate = null;
      clearLogoutTimer();
      updateAuthStatus(false);
      switchDataSource(true);
    }
  }

  @action
  Future<void> autoLogout() async {
    clearLogoutTimer();
    final _timeToLogout = _expiryDate?.difference(DateTime.now()).inHours;
    _logoutTimer = Timer(
      Duration(
        hours: _timeToLogout ?? 0,
      ),
      logout,
    );
  }

  void clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void switchDataSource(bool offline) {
    final dataSourceProxy = getIt<ProductDataSourceProxy>();

    if (offline) {
      dataSourceProxy.switchDataSource(getIt<ProductRemoteDataSourceOffline>());
    } else {
      dataSourceProxy.switchDataSource(getIt<ProductRemoteDataSourceOnline>());
    }
  }

  @action
  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final user = await _getCurrentUserUsecase.call();
    UserResponse? currentUser;
    user.fold((l) {}, (r) {
      currentUser = r;
    });
    if (currentUser == null) return;

    if (currentUser!.expiryDate.isBefore(DateTime.now())) return;

    _token = currentUser!.token;
    _userId = currentUser!.id;
    _expiryDate = currentUser!.expiryDate;

    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    updateAuthStatus(_token != null && isValid);
  }
}

abstract class AuthState {}

class AuthIdle extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
