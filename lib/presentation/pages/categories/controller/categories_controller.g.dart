// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoriesController on _CategoriesControllerBase, Store {
  late final _$filteredProductsAtom = Atom(
      name: '_CategoriesControllerBase.filteredProducts', context: context);

  @override
  ObservableList<ProductEntity> get filteredProducts {
    _$filteredProductsAtom.reportRead();
    return super.filteredProducts;
  }

  @override
  set filteredProducts(ObservableList<ProductEntity> value) {
    _$filteredProductsAtom.reportWrite(value, super.filteredProducts, () {
      super.filteredProducts = value;
    });
  }

  late final _$productsAtom =
      Atom(name: '_CategoriesControllerBase.products', context: context);

  @override
  List<ProductEntity> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(List<ProductEntity> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$toggleWasBoughtAsyncAction = AsyncAction(
      '_CategoriesControllerBase.toggleWasBought',
      context: context);

  @override
  Future<void> toggleWasBought(ProductEntity product) {
    return _$toggleWasBoughtAsyncAction
        .run(() => super.toggleWasBought(product));
  }

  late final _$listByCategoryAsyncAction =
      AsyncAction('_CategoriesControllerBase.listByCategory', context: context);

  @override
  Future<void> listByCategory(int categoryId) {
    return _$listByCategoryAsyncAction
        .run(() => super.listByCategory(categoryId));
  }

  late final _$updateProductAsyncAction =
      AsyncAction('_CategoriesControllerBase.updateProduct', context: context);

  @override
  Future<void> updateProduct(ProductModel product, {File? image}) {
    return _$updateProductAsyncAction
        .run(() => super.updateProduct(product, image: image));
  }

  late final _$createProductAsyncAction =
      AsyncAction('_CategoriesControllerBase.createProduct', context: context);

  @override
  Future<void> createProduct(ProductModel product, {File? image}) {
    return _$createProductAsyncAction
        .run(() => super.createProduct(product, image: image));
  }

  late final _$deleteProductAsyncAction =
      AsyncAction('_CategoriesControllerBase.deleteProduct', context: context);

  @override
  Future<void> deleteProduct(ProductEntity product) {
    return _$deleteProductAsyncAction.run(() => super.deleteProduct(product));
  }

  late final _$_CategoriesControllerBaseActionController =
      ActionController(name: '_CategoriesControllerBase', context: context);

  @override
  void setProducts(List<ProductEntity> list) {
    final _$actionInfo = _$_CategoriesControllerBaseActionController
        .startAction(name: '_CategoriesControllerBase.setProducts');
    try {
      return super.setProducts(list);
    } finally {
      _$_CategoriesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProduct(ProductEntity product) {
    final _$actionInfo = _$_CategoriesControllerBaseActionController
        .startAction(name: '_CategoriesControllerBase.setProduct');
    try {
      return super.setProduct(product);
    } finally {
      _$_CategoriesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteProductFromList(ProductEntity product) {
    final _$actionInfo = _$_CategoriesControllerBaseActionController
        .startAction(name: '_CategoriesControllerBase.deleteProductFromList');
    try {
      return super.deleteProductFromList(product);
    } finally {
      _$_CategoriesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filteredProducts: ${filteredProducts},
products: ${products}
    ''';
  }
}
