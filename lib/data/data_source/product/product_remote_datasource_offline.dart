import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource.dart';
import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductRemoteDataSourceOffline implements IProductDataSource {
  HiveInterface _hive;

  ProductRemoteDataSourceOffline({required HiveInterface hive}) : _hive = hive;

  @override
  Future<ProductEntity> createProduct(ProductModel product,
      {File? imageFile}) async {
    ProductEntity entity = product.toEntity();
    entity.id = UniqueKey().toString();
    entity.image = imageFile?.path;
    final box = await _openBox('CATEGORY: ${product.category}');

    await box.add(entity);
    box.close();
    return entity;
  }

  @override
  Future<String> deleteProduct(ProductEntity product) async {
    final box = await _openBox('CATEGORY: ${product.category}');
    try {
      box.delete(product.id);
    } catch (e) {
      rethrow;
    }
    return 'Produto deletado com sucesso';
  }

  @override
  Future<ProductEntity> editProduct(ProductModel product, {File? image}) async {
    final box = await _openBox('CATEGORY: ${product.category}');
    print("ProductIDModel: ${product.id}");
    ProductEntity entity = product.toEntity();
    print("ProductIDEntity: ${entity.id}");
    entity.image = image?.path;
    try {
      box.get(entity.id);
      box.put(entity.id, entity);
    } catch (e) {
      rethrow;
    }
    return entity;
  }

  @override
  Future<ProductResponse> getProducts() {
    throw UnimplementedError();
  }

  @override
  Future<ProductResponse> getProductsByCategory(int categoryId) async {
    final Box box = await _openBox('CATEGORY: $categoryId');
    final products = box.values
        .map((productEntity) => productEntity as ProductEntity)
        .toList();
    ProductResponse response = ProductResponse(data: products);
    List<String?> ids = [];
    for (var product in response.data) {
      ids.add(product.id);
    }
    print(ids);
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
