import 'package:dartz/dartz.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/domain/repositories/user_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthenticateUsecase {
  final IUserRepository _repository;

  AuthenticateUsecase({required IUserRepository repository})
      : _repository = repository;

  Future<Either<Failure, UserResponse>> call(
      AuthRequest request, bool isLogin) async {
    if (isLogin) {
      return _repository.login(request);
    } else {
      return _repository.register(request);
    }
  }
}
