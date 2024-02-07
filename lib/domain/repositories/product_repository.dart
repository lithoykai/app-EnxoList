import 'package:dartz/dartz.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/infra/failure/failure.dart';

abstract class IProductRepository {
  Future<Either<Failure, ProductResponse>> getProducts();
  Future<Either<Failure, ProductResponse>> getProductsByCategory(
      int categoryId);
}
