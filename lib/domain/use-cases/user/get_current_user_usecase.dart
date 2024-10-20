import 'package:dartz/dartz.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/domain/repositories/user_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentUserUsecase {
  final IUserRepository _repository;

  GetCurrentUserUsecase({required IUserRepository repository})
      : _repository = repository;

  Future<Either<Failure, UserResponse>> call() async {
    return await _repository.getCurrentUser();
  }
}
