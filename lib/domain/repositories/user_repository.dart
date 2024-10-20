import 'package:dartz/dartz.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/data/models/auth/response/user_DTO.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/infra/failure/failure.dart';

abstract interface class IUserRepository {
  Future<Either<Failure, UserResponse>> login(AuthRequest request);
  Future<Either<Failure, UserResponse>> register(AuthRequest request);
  Future<Either<Failure, bool>> refuseCouple(String coupleId);
  Future<Either<Failure, bool>> acceptCouple(String coupleId);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, UserDTO>> getCoupleUser(String coupleId);
  Future<Either<Failure, UserResponse>> getCurrentUser();
}
