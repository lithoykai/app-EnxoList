import 'package:dartz/dartz.dart';
import 'package:enxolist/domain/repositories/product_repository.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/infra/failure/failure.dart';

class GetProductsUseCase {
  IProductRepository _repository;

  GetProductsUseCase({required IProductRepository repository})
      : _repository = repository;

  Future<Either<Failure, ProductResponse>> call() {
    return _repository.getProducts();
  }
}
