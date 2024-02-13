import 'package:dartz/dartz.dart';
import 'package:enxolist/domain/repositories/product_repository.dart';
import 'package:enxolist/domain/use-cases/product/create_product.dart';
import 'package:enxolist/domain/use-cases/product/delete_product.dart';
import 'package:enxolist/domain/use-cases/product/get_products.dart';
import 'package:enxolist/presentation/pages/categories/controller/categories_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/src/mock.dart' as mock;

import '../../../../fixtures/product_fixture.dart';
import 'categories_controller.mocks.dart';

@GenerateMocks([
  GetProductsUseCase,
  DeleteProductUseCase,
  CreateProductUseCase,
  IProductRepository
])
void main() {
  late CategoriesController controller;
  late GetProductsUseCase getProductsUseCase;
  late DeleteProductUseCase deleteProductUseCase;
  late CreateProductUseCase createProductUseCase;

  setUp(() {
    getProductsUseCase = MockGetProductsUseCase();
    deleteProductUseCase = MockDeleteProductUseCase();
    createProductUseCase = MockCreateProductUseCase();
    controller = CategoriesController(
      getProductsUseCase: getProductsUseCase,
      deleteProductUseCase: deleteProductUseCase,
      createProductUseCase: createProductUseCase,
    );
  });

  test('Should add the products to the products list when calling getProducts',
      () {
    final _fixture = responseProduct;
    final _fakeProductModel = fakeProductModel;
    final int lenght = controller.products.length;
    mock
        .when(getProductsUseCase.callCategory(1))
        .thenAnswer((_) async => Right(_fixture));
    controller.listByCategory(1);
    expect(controller.products.length, 1);
  });
  test('Should add new product when call create product', () {
    final _fixture = fakeProduct;
    final _fakeProductModel = fakeProductModel;
    final int lenght = controller.products.length;
    mock
        .when(createProductUseCase.call(_fakeProductModel))
        .thenAnswer((_) async => Right(_fixture));
    controller.createProduct(_fakeProductModel);
    expect(controller.products.length, lenght + 1);
  });
}
