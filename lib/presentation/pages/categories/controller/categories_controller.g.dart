// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoriesController on _CategoriesControllerBase, Store {
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

  late final _$listByCategoryAsyncAction =
      AsyncAction('_CategoriesControllerBase.listByCategory', context: context);

  @override
  Future<void> listByCategory(int categoryId) {
    return _$listByCategoryAsyncAction
        .run(() => super.listByCategory(categoryId));
  }

  late final _$deleteProductAsyncAction =
      AsyncAction('_CategoriesControllerBase.deleteProduct', context: context);

  @override
  Future<void> deleteProduct(ProductEntity product) {
    return _$deleteProductAsyncAction.run(() => super.deleteProduct(product));
  }

  @override
  String toString() {
    return '''
products: ${products}
    ''';
  }
}
