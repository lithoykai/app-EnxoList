import 'package:dartz/dartz.dart';
import 'package:enxolist/data/models/product/cost_values_model.dart';
import 'package:enxolist/infra/failure/failure.dart';

abstract class CostValuesRepository {
  Future<Either<Failure, List<CostValuesModel>>> getCostValues();
}
