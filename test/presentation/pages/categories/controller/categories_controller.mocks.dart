// Mocks generated by Mockito 5.4.4 from annotations
// in enxolist/test/presentation/pages/categories/controller/categories_controller.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:io' as _i11;

import 'package:dartz/dartz.dart' as _i2;
import 'package:enxolist/data/models/product/product_model.dart' as _i10;
import 'package:enxolist/domain/entities/product/product_entity.dart' as _i7;
import 'package:enxolist/domain/repositories/product_repository.dart' as _i12;
import 'package:enxolist/domain/response/product_response.dart' as _i6;
import 'package:enxolist/domain/use-cases/product/create_product.dart' as _i9;
import 'package:enxolist/domain/use-cases/product/delete_product.dart' as _i8;
import 'package:enxolist/domain/use-cases/product/get_products.dart' as _i3;
import 'package:enxolist/infra/failure/failure.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetProductsUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetProductsUseCase extends _i1.Mock
    implements _i3.GetProductsUseCase {
  MockGetProductsUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.ProductResponse>> call() =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.ProductResponse>>.value(
                _FakeEither_0<_i5.Failure, _i6.ProductResponse>(
          this,
          Invocation.method(
            #call,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.ProductResponse>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.ProductResponse>> callCategory(
          int? categoryId) =>
      (super.noSuchMethod(
        Invocation.method(
          #callCategory,
          [categoryId],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.ProductResponse>>.value(
                _FakeEither_0<_i5.Failure, _i6.ProductResponse>(
          this,
          Invocation.method(
            #callCategory,
            [categoryId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.ProductResponse>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> updateWasBought(
          _i7.ProductEntity? product) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateWasBought,
          [product],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #updateWasBought,
            [product],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
}

/// A class which mocks [DeleteProductUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteProductUseCase extends _i1.Mock
    implements _i8.DeleteProductUseCase {
  MockDeleteProductUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> delete(
          _i7.ProductEntity? product) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [product],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #delete,
            [product],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
}

/// A class which mocks [CreateProductUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockCreateProductUseCase extends _i1.Mock
    implements _i9.CreateProductUseCase {
  MockCreateProductUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.ProductEntity>> call(
    _i10.ProductModel? product, {
    _i11.File? image,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [product],
          {#image: image},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i7.ProductEntity>>.value(
                _FakeEither_0<_i5.Failure, _i7.ProductEntity>(
          this,
          Invocation.method(
            #call,
            [product],
            {#image: image},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.ProductEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.ProductEntity>> update(
    _i10.ProductModel? product, {
    _i11.File? image,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #update,
          [product],
          {#image: image},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i7.ProductEntity>>.value(
                _FakeEither_0<_i5.Failure, _i7.ProductEntity>(
          this,
          Invocation.method(
            #update,
            [product],
            {#image: image},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.ProductEntity>>);
}

/// A class which mocks [IProductRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIProductRepository extends _i1.Mock
    implements _i12.IProductRepository {
  MockIProductRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.ProductResponse>> getProducts() =>
      (super.noSuchMethod(
        Invocation.method(
          #getProducts,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.ProductResponse>>.value(
                _FakeEither_0<_i5.Failure, _i6.ProductResponse>(
          this,
          Invocation.method(
            #getProducts,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.ProductResponse>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.ProductResponse>>
      getProductsByCategory(int? categoryId) => (super.noSuchMethod(
            Invocation.method(
              #getProductsByCategory,
              [categoryId],
            ),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, _i6.ProductResponse>>.value(
                    _FakeEither_0<_i5.Failure, _i6.ProductResponse>(
              this,
              Invocation.method(
                #getProductsByCategory,
                [categoryId],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.Failure, _i6.ProductResponse>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> deleteProduct(
          _i7.ProductEntity? product) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteProduct,
          [product],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #deleteProduct,
            [product],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> updateWasBought(
          _i7.ProductEntity? product) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateWasBought,
          [product],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #updateWasBought,
            [product],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.ProductEntity>> createProduct(
    _i10.ProductModel? product, {
    _i11.File? image,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createProduct,
          [product],
          {#image: image},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i7.ProductEntity>>.value(
                _FakeEither_0<_i5.Failure, _i7.ProductEntity>(
          this,
          Invocation.method(
            #createProduct,
            [product],
            {#image: image},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.ProductEntity>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i7.ProductEntity>> updateProduct(
    _i10.ProductModel? product, {
    _i11.File? image,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateProduct,
          [product],
          {#image: image},
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i7.ProductEntity>>.value(
                _FakeEither_0<_i5.Failure, _i7.ProductEntity>(
          this,
          Invocation.method(
            #updateProduct,
            [product],
            {#image: image},
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i7.ProductEntity>>);
}
