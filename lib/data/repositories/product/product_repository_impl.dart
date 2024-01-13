import 'package:dartz/dartz.dart';
import 'package:enxolist/data/data_source/product_remote_datasource.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:enxolist/repositories/product_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IProductRepository)
class ProductRepositoryImpl implements IProductRepository {
  final IProductDataSource _dataSource;

  ProductRepositoryImpl({required IProductDataSource dataSouce})
      : _dataSource = dataSouce;

  @override
  Future<Either<Failure, ProductResponse>> getProducts() async {
    try {
      final _response = await _dataSource.getProducts();
      return right(_response);
    } catch (e) {
      return left(ServerFailure(msg: 'genericListError'));
    }
  }
}
