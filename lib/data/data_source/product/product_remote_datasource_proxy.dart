import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource.dart';
import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/response/product_response.dart';

class ProductDataSourceProxy implements IProductDataSource {
  late IProductDataSource _currentDataSource;

  ProductDataSourceProxy(IProductDataSource initialDataSource) {
    _currentDataSource = initialDataSource;
  }

  void switchDataSource(IProductDataSource newDataSource) {
    _currentDataSource = newDataSource;
  }

  @override
  Future<ProductResponse> getProducts() {
    return _currentDataSource.getProducts();
  }

  @override
  Future<ProductResponse> getProductsByCategory(int categoryId) {
    return _currentDataSource.getProductsByCategory(categoryId);
  }

  @override
  Future<String> deleteProduct(ProductEntity product) {
    return _currentDataSource.deleteProduct(product);
  }

  @override
  Future<Response> updateWasBought(ProductEntity product) {
    return _currentDataSource.updateWasBought(product);
  }

  @override
  Future<ProductEntity> editProduct(ProductModel product, {File? image}) {
    return _currentDataSource.editProduct(product, image: image);
  }

  @override
  Future<ProductEntity> createProduct(ProductModel product, {File? imageFile}) {
    return _currentDataSource.createProduct(product, imageFile: imageFile);
  }
}
