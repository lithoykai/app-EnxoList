import 'package:dartz/dartz.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/repositories/product_repository.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUseCase {
  IProductRepository _repository;

  GetProductsUseCase({required IProductRepository repository})
      : _repository = repository;

  Future<Either<Failure, ProductResponse>> call() {
    return _repository.getProducts();
  }

  Future<Either<Failure, ProductResponse>> callCategory(int categoryId) {
    return _repository.getProductsByCategory(categoryId);
  }

  Future<Either<Failure, String>> updateWasBought(ProductEntity product) {
    return _repository.updateWasBought(product);
  }
}
