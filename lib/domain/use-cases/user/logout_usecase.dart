import 'package:dartz/dartz.dart';
import 'package:enxolist/domain/repositories/user_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUsecase {
  final IUserRepository _repository;

  LogoutUsecase({required IUserRepository repository})
      : _repository = repository;

  Future<Either<Failure, bool>> call() async {
    return await _repository.logout();
  }
}
