import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/response/product_response.dart';

abstract class IProductDataSource {
  Future<ProductResponse> getProducts();

  Future<ProductResponse> getProductsByCategory(int categoryId);

  Future<Response> deleteProduct(ProductEntity product);

  Future<Response> updateWasBought(ProductEntity product);

  Future<ProductEntity> editProduct(ProductModel product, {File? image});

  Future<ProductEntity> createProduct(ProductModel product, {File? imageFile});
}
