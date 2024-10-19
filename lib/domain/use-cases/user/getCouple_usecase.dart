import 'package:dartz/dartz.dart';
import 'package:enxolist/data/models/auth/response/user_DTO.dart';
import 'package:enxolist/domain/repositories/user_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCoupleUseCase {
  final IUserRepository _repository;
  GetCoupleUseCase({required IUserRepository repository})
      : _repository = repository;
  Future<Either<Failure, UserDTO>> call(String coupleId) async {
    return await _repository.getCoupleUser(coupleId);
  }
}
