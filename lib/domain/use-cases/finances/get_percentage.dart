import 'package:dartz/dartz.dart';
import 'package:enxolist/data/models/product/cost_values_model.dart';
import 'package:enxolist/domain/repositories/cost_values_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPercetangeUseCase {
  CostValuesRepository _repository;

  GetPercetangeUseCase({required CostValuesRepository repository})
      : _repository = repository;

  Future<Either<Failure, List<CostValuesModel>>> call() async {
    return _repository.getCostValues();
  }
}
