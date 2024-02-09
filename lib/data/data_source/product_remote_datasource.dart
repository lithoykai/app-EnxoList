import 'package:dio/dio.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/response/product_response.dart';

abstract class IProductDataSource {
  Future<ProductResponse> getProducts();

  Future<ProductResponse> getProductsByCategory(int categoryId);

  Future<Response> deleteProduct(ProductEntity product);
}
