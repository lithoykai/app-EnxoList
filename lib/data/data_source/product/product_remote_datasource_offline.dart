import 'dart:io';

import 'package:dio/src/response.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource.dart';
import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductRemoteDataSourceOffline implements IProductDataSource {
  HiveInterface _hive;

  ProductRemoteDataSourceOffline({required HiveInterface hive}) : _hive = hive;

  @override
  Future<ProductEntity> createProduct(ProductModel product,
      {File? imageFile}) async {
    ProductEntity entity = product.toEntity();
    entity.image = imageFile?.path;
    final box = await _openBox('CATEGORY: ${product.category}');

    await box.add(entity);

    return entity;
  }

  @override
  Future<Response> deleteProduct(ProductEntity product) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductEntity> editProduct(ProductModel product, {File? image}) {
    // TODO: implement editProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductResponse> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<ProductResponse> getProductsByCategory(int categoryId) async {
    final Box box = await _openBox('CATEGORY: $categoryId');
    final products = box.values
        .map((productEntity) => productEntity as ProductEntity)
        .toList();
    ProductResponse response = ProductResponse(data: products);
    return response;
  }

  @override
  Future<Response> updateWasBought(ProductEntity product) {
    // TODO: implement updateWasBought
    throw UnimplementedError();
  }

  Future<Box> _openBox(String type) async {
    try {
      final box = _hive.openBox(type);

      return box;
    } catch (e) {
      throw Exception(e);
    }
  }
}
