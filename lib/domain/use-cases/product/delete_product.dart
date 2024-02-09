import 'package:dartz/dartz.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/repositories/product_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteProductUseCase {
  IProductRepository _repository;

  DeleteProductUseCase({required IProductRepository repository})
      : _repository = repository;

  Future<Either<Failure, String>> delete(ProductEntity product) {
    return _repository.deleteProduct(product);
  }
}
