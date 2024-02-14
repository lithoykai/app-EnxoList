import 'dart:io';

import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/use-cases/product/create_product.dart';
import 'package:enxolist/domain/use-cases/product/delete_product.dart';
import 'package:enxolist/domain/use-cases/product/get_products.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'categories_controller.g.dart';

@singleton
class CategoriesController = _CategoriesControllerBase
    with _$CategoriesController;

abstract class _CategoriesControllerBase with Store {
  final GetProductsUseCase _getProductsUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final CreateProductUseCase _createProductUseCase;

  _CategoriesControllerBase(
      {required GetProductsUseCase getProductsUseCase,
      required DeleteProductUseCase deleteProductUseCase,
      required CreateProductUseCase createProductUseCase})
      : _getProductsUseCase = getProductsUseCase,
        _createProductUseCase = createProductUseCase,
        _deleteProductUseCase = deleteProductUseCase;

  @observable
  ObservableList<ProductEntity> filteredProducts =
      ObservableList<ProductEntity>();
  @observable
  List<ProductEntity> products = ObservableList.of([]);

  void searchProducts(String searchTerm) {
    if (searchTerm.isEmpty) {
      filteredProducts.clear();
      filteredProducts.addAll(products);
      filteredProducts.sort((a, b) => a.wasBought ? 1 : -1);
    } else {
      filteredProducts.clear();
      filteredProducts.addAll(products.where((product) =>
          product.name.toLowerCase().contains(searchTerm.toLowerCase())));
      filteredProducts.sort((a, b) => a.wasBought ? 1 : -1);
    }
  }

  @action
  void setProducts(List<ProductEntity> list) {
    products = ObservableList.of(list);
    products.sort((a, b) => a.wasBought ? 1 : -1);
    filteredProducts = ObservableList.of(list);
    filteredProducts.sort((a, b) => a.wasBought ? 1 : -1);
  }

  void setProduct(ProductEntity product) {
    products.add(product);
    filteredProducts.add(product);
  }

  void updateProductFromList(ProductEntity product) {
    int index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      products[index] = product;

      updateProductInFilteredList(product);
    }
  }

  void updateProductInFilteredList(ProductEntity product) {
    int index = filteredProducts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      filteredProducts[index] = product;
    }
  }

  @action
  void deleteProductFromList(ProductEntity product) {
    products.remove(product);
    filteredProducts.remove(product);
  }

  @action
  Future<void> toggleWasBought(ProductEntity product) async {
    product.toggleWasBought();
    _getProductsUseCase.updateWasBought(product);
  }

  @action
  Future<void> listByCategory(int categoryId) async {
    final _response = await _getProductsUseCase.callCategory(categoryId);
    _response.fold((l) {
      l as ServerFailure;
    }, (r) => setProducts(r.data));
  }

  @action
  Future<void> updateProduct(ProductModel product, {File? image}) async {
    final _response = await _createProductUseCase.update(product, image: image);
    _response.fold((l) {
      l as ServerFailure;
      throw ServerFailure(msg: l.msg);
    }, (r) => updateProductFromList(r));
  }

  @action
  Future<void> createProduct(ProductModel product, {File? image}) async {
    final _response = await _createProductUseCase.call(product, image: image);
    _response.fold((l) {
      l as ServerFailure;

      throw ServerFailure(msg: l.msg);
    }, (r) => setProduct(r));
  }

  @action
  Future<void> deleteProduct(ProductEntity product) async {
    final _response = await _deleteProductUseCase.delete(product);
    _response.fold((l) {
      l as ServerFailure;
      print(l.msg);
      throw ServerFailure(msg: l.toString());
    }, (r) => deleteProductFromList(product));
  }
}
