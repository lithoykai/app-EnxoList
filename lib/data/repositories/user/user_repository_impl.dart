import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/user/user_remote_datasource.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/data/models/auth/response/user_DTO.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/domain/repositories/user_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  late Box _userBox;
  late Box _coupleBox;
  final _dataSource;
  final HiveInterface _hive;

  UserRepositoryImpl(
      {required IUserRemoteDataSource dataSource, required HiveInterface hive})
      : _dataSource = dataSource,
        _hive = hive;

  @override
  Future<Either<Failure, UserResponse>> login(AuthRequest request) async {
    try {
      final response = await _dataSource.login(request);

      if (response.statusCode != 200) {
        return Left(AuthFailure(msg: response.data['error']));
      }

      Map<String, dynamic> data = response.data;
      UserResponse user = UserResponse.fromJson(data);

      await _openBoxIfNeeded();
      await _userBox.put('userData', user);
      return Right(user);
    } on DioException catch (e) {
      return Left(
          AuthFailure(msg: e.toString(), statusCode: e.response?.statusCode));
    } catch (e) {
      return Left(AppFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserResponse>> register(AuthRequest request) async {
    try {
      final response = await _dataSource.register(request: request);

      if (response.statusCode != 200) {
        return Left(AuthFailure(msg: response.data['error']));
      }

      Map<String, dynamic> data = response.data;
      UserResponse user = UserResponse.fromJson(data);

      await _openBoxIfNeeded();
      await _userBox.put('userData', user);

      return Right(user);
    } on DioException catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    } on Exception catch (e) {
      return Left(AppFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> acceptCouple(String coupleId) async {
    try {
      await _openBoxIfNeeded();
      UserResponse? user = await getUserData();
      final response = await _dataSource.acceptCoupleUser(
          coupleId: coupleId, userID: user.id);
      if (response.statusCode != 200) {
        return Left(AuthFailure(msg: response.data['error']));
      }
      return const Right(true);
    } on DioException catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    } on HiveError catch (e) {
      return Left(AppFailure(msg: e.toString()));
    } catch (e) {
      return Left(AppFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserDTO>> getCoupleUser(String coupleId) async {
    try {
      final response = await _dataSource.getCoupleUser(coupleId: coupleId);
      if (response.statusCode != 200) {
        return Left(AuthFailure(msg: response.data['error']));
      }

      await _openBoxIfNeeded();
      final coupleUser = UserDTO.fromJson(response.data);
      await _userBox.put('coupleData', coupleUser);
      return Right(coupleUser);
    } catch (e) {
      return Left(AppFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await _openBoxIfNeeded();
      await _userBox.clear();
      await _coupleBox.clear();
      return const Right(true);
    } on HiveError catch (e) {
      return Left(AppFailure(msg: e.toString()));
    } catch (e) {
      return Left(AppFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> refuseCouple(
    String coupleId,
  ) async {
    try {
      await _openBoxIfNeeded();
      UserResponse? user = await getUserData();
      final response =
          await _dataSource.refuseCouple(coupleId: coupleId, userID: user.id);
      if (response.statusCode != 200) {
        return Left(AuthFailure(msg: response.data['error']));
      }

      user.isCouple = false;
      user.userCoupleId = null;
      await _userBox.put('userData', user);
      return const Right(true);
    } on DioException catch (e) {
      return Left(ServerFailure(msg: e.toString()));
    } on HiveError catch (e) {
      return Left(AppFailure(msg: e.toString()));
    } catch (e) {
      return Left(AppFailure(msg: e.toString()));
    }
  }

  Future<void> _openBoxIfNeeded() async {
    if (Hive.isBoxOpen('userData')) {
      _userBox = Hive.box('userData');
    }
    if (!_hive.isBoxOpen('userData')) {
      _userBox = await _hive.openBox('userData');
    }
    if (!_hive.isBoxOpen('coupleData')) {
      _coupleBox = await _hive.openBox('coupleData');
    }
  }

  Future<UserResponse> getUserData() async {
    await _openBoxIfNeeded();
    UserResponse? user = _userBox.get('userData');
    if (user == null) {
      throw AppFailure(msg: 'Usuário não encontrado');
    }
    return user;
  }

  @override
  Future<Either<Failure, UserResponse>> getCurrentUser() async {
    try {
      UserResponse user = await getUserData();
      return Right(user);
    } on HiveError catch (e) {
      return Left(AppFailure(msg: e.toString()));
    } catch (e) {
      return Left(AppFailure(msg: e.toString()));
    }
  }
}
