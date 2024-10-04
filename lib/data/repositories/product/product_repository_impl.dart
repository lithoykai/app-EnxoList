import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource.dart';
import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/repositories/product_repository.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IProductRepository)
class ProductRepositoryImpl implements IProductRepository {
  final IProductDataSource _dataSource;

  ProductRepositoryImpl({required IProductDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Failure, ProductResponse>> getProducts() async {
    try {
      final _response = await _dataSource.getProducts();
      return right(_response);
    } on DioException catch (e) {
      return left(ServerFailure(msg: 'Erro ao obter dados do servidor.'));
    } on Exception catch (e) {
      return left(AppFailure(
          msg: 'Ocorreu um erro desconhecido ao tentar obter os produtos.'));
    }
  }

  @override
  Future<Either<Failure, ProductResponse>> getProductsByCategory(
      int categoryId) async {
    try {
      final _response = await _dataSource.getProductsByCategory(categoryId);
      return right(_response);
    } on DioException catch (e) {
      return left(ServerFailure(msg: 'Erro ao obter dados do servidor. $e'));
    } on Exception catch (e) {
      return left(AppFailure(
          msg: 'Ocorreu um erro desconhecido ao tentar obter os produtos. $e'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct(ProductEntity product) async {
    try {
      final _response = await _dataSource.deleteProduct(product);
      Map<String, dynamic> data = _response.data;
      final result = data['msg'];
      return right(result);
    } on DioException {
      return left(
          ServerFailure(msg: 'Estamos com algum problema no servidor.'));
    } on Exception catch (e) {
      return left(AppFailure(
          msg: 'Ocorreu um erro desconhecido ao tentar deletar o produto.'));
    }
  }

  @override
  Future<Either<Failure, String>> updateWasBought(ProductEntity product) async {
    try {
      final _response = await _dataSource.updateWasBought(product);
      return right('Atualizado!');
    } on DioException {
      return left(ServerFailure(msg: 'Erro ao obter dados do servidor.'));
    } catch (e) {
      return left(AppFailure(
          msg: 'Ocorreu um erro desconhecido ao tentar atualizar o produto.'));
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
    } on DioException {
      return left(ServerFailure(msg: 'Erro ao obter dados do servidor.'));
    } catch (e) {
      return left(AppFailure(
          msg: 'Ocorreu um erro desconhecido ao tentar criar o produto.'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(ProductModel product,
      {File? image}) async {
    try {
      final _response = await _dataSource.editProduct(product, image: image);
      return right(_response);
    } on DioException {
      return left(ServerFailure(msg: 'Erro ao obter dados do servidor.'));
    } catch (e) {
      return left(AppFailure(
          msg: 'Ocorreu um erro desconhecido ao tentar atualizar o produto.'));
    }
  }
}
