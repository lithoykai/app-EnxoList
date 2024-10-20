import 'package:dartz/dartz.dart';
import 'package:enxolist/domain/repositories/user_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class RefuseCoupleUseCase {
  final IUserRepository _repository;

  RefuseCoupleUseCase({required IUserRepository repository})
      : _repository = repository;

  Future<Either<Failure, bool>> call(String coupleId) async {
    return await _repository.refuseCouple(coupleId);
  }
}
