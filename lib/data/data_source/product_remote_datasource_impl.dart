import 'dart:io';

import 'package:dio/src/response.dart';
import 'package:enxolist/data/data_source/clients/http_clients.dart';
import 'package:enxolist/data/data_source/product_remote_datasource.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/data/services/firebase/firebase_service.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IProductDataSource)
class ProductDataSourceImpl implements IProductDataSource {
  HttpClientApp _http;
  FirebaseService _firebaseService;

  ProductDataSourceImpl(
      {required HttpClientApp http, required FirebaseService firebaseService})
      : _http = http,
        _firebaseService = firebaseService;

  @override
  Future<ProductResponse> getProducts() async {
    try {
      final response = await _http.getMethod(Endpoints.products);

      final data = (response.data as List)
          .map((json) => ProductModel.fromJson(json).toEntity())
          .toList();

      final result = ProductResponse(data: data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductResponse> getProductsByCategory(int categoryId) async {
    UserResponse? user;
    if (Hive.isBoxOpen('userData')) {
      var box = Hive.box('userData');
      user = box.get('userData');
    }

    try {
      final response = await _http
          .getMethod('${Endpoints.products}/${user!.id}/category/$categoryId');

      final data = (response.data as List)
          .map((json) => ProductModel.fromJson(json).toEntity())
          .toList();

      final result = ProductResponse(data: data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> deleteProduct(ProductEntity product) async {
    try {
      final response =
          await _http.delete('${Endpoints.deleteProduct}/${product.id}');
      if (product.image != null) {
        await _firebaseService.deleteImage(product.image!);
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> updateWasBought(ProductEntity product) async {
    Map<String, dynamic> data = {
      "wasBought": product.wasBought,
      "price": product.price,
      "category": product.category,
    };
    try {
      final _response =
          await _http.put('${Endpoints.products}/${product.id}', data);
      return _response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductEntity> createProduct(ProductModel product,
      {File? imageFile}) async {
    try {
      String? imageUrl;
      final _response =
          await _http.post('${Endpoints.products}/create', product.toJson());
      final data = _response.data as Map<String, dynamic>;
      ProductEntity productEntity = ProductModel.fromJson(data).toEntity();
      if (imageFile != null) {
        final imageUrl = await _firebaseService.uploadImage(
            imageFile, productEntity.id ?? productEntity.name);
        productEntity.image = imageUrl;
        await _http.put('${Endpoints.products}/${productEntity.id}',
            productEntity.toJson());
      }

      return productEntity;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductEntity> editProduct(ProductModel product, {File? image}) async {
    try {
      if (image != null) {
        final imageUrl = await _firebaseService.uploadImage(
            image, product.id ?? product.name);
        product.image = imageUrl;
      }
      final _response = await _http.put(
          '${Endpoints.products}/${product.id}', product.toJson());
      final data = _response.data as Map<String, dynamic>;
      ProductEntity productEntity = ProductModel.fromJson(data);
      return productEntity;
    } catch (e) {
      rethrow;
    }
  }
}
