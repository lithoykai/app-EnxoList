import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/repositories/product_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateProductUseCase {
  IProductRepository _repository;

  CreateProductUseCase({required IProductRepository repository})
      : _repository = repository;

  Future<Either<Failure, ProductEntity>> call(ProductModel product,
      {File? image}) async {
    if (image != null) {
      return _repository.createProduct(product, image: image);
    }
    return _repository.createProduct(product, image: image);
  }
}
