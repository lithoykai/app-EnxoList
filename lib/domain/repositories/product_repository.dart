import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/infra/failure/failure.dart';

abstract class IProductRepository {
  Future<Either<Failure, ProductResponse>> getProducts();
  Future<Either<Failure, ProductResponse>> getProductsByCategory(
      int categoryId);
  Future<Either<Failure, String>> deleteProduct(ProductEntity product);
  Future<Either<Failure, String>> updateWasBought(ProductEntity product);
  Future<Either<Failure, ProductEntity>> createProduct(ProductModel product,
      {File? image});
}
