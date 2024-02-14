import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:enxolist/data/data_source/product_remote_datasource.dart';
import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/repositories/product_repository.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IProductRepository)
class ProductRepositoryImpl implements IProductRepository {
  final IProductDataSource _dataSource;

  ProductRepositoryImpl({required IProductDataSource dataSouce})
      : _dataSource = dataSouce;

  @override
  Future<Either<Failure, ProductResponse>> getProducts() async {
    try {
      final _response = await _dataSource.getProducts();
      return right(_response);
    } catch (e) {
      return left(ServerFailure(msg: 'genericListError'));
    }
  }

  @override
  Future<Either<Failure, ProductResponse>> getProductsByCategory(
      int categoryId) async {
    try {
      final _response = await _dataSource.getProductsByCategory(categoryId);
      return right(_response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct(ProductEntity product) async {
    try {
      final _response = await _dataSource.deleteProduct(product);
      Map<String, dynamic> data = _response.data;
      final result = data['msg'];
      return right(result);
    } catch (e) {
      print(e);
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateWasBought(ProductEntity product) async {
    try {
      final _response = await _dataSource.updateWasBought(product);
      return right('Atualizado!');
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> createProduct(ProductModel product,
      {File? image}) async {
    try {
      if (image != null) {
        final _response =
            await _dataSource.createProduct(product, imageFile: image);
        return right(_response);
      }
      final _response = await _dataSource.createProduct(product);
      return right(_response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(ProductModel product,
      {File? image}) async {
    try {
      final _response = await _dataSource.editProduct(product, image: image);
      return right(_response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
