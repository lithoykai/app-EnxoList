import 'package:dartz/dartz.dart';
import 'package:enxolist/data/data_source/cost_values_remote_datasource.dart';
import 'package:enxolist/data/models/product/cost_values_model.dart';
import 'package:enxolist/domain/repositories/cost_values_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CostValuesRepository)
class CostValuesRepositoryImpl implements CostValuesRepository {
  CostValuesDataSource _dataSource;

  CostValuesRepositoryImpl({required CostValuesDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Failure, List<CostValuesModel>>> getCostValues() async {
    try {
      final _response = await _dataSource.getItensPercentage();
      return right(_response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
