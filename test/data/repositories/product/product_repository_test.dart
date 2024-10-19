import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource_online.dart';
import 'package:enxolist/data/repositories/product/product_repository_impl.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/repositories/product_repository.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/product_fixture.dart';
import 'product_repository_test.mocks.dart';

@GenerateMocks([ProductRemoteDataSourceOnline])
void main() {
  late IProductRepository repository;
  late IProductDataSource dataSource;

  setUp(() {
    dataSource = MockProductRemoteDataSourceOnline();
    repository = ProductRepositoryImpl(dataSource: dataSource);
  });

  group(
    'test product repository',
    () {
      test('When try get list products then return a right ProductResponse',
          () async {
        final _fixture = responseProduct;

        when(dataSource.getProducts()).thenAnswer((_) async => responseProduct);

        final _response = await repository.getProducts();
        final _result = _response.fold((l) => l, (r) => r);

        expect(_result, isA<ProductResponse>());
      });

      test('Should return a AppFailure when try get list products', () async {
        when(dataSource.getProducts()).thenThrow(Exception());

        final _response = await repository.getProducts();
        final _result = _response.fold((l) => l, (r) => r);

        expect(_result, isA<AppFailure>());
      });
      test('Should return a ServerFailure when try get list products',
          () async {
        when(dataSource.getProducts())
            .thenThrow(DioException(requestOptions: RequestOptions()));

        final _response = await repository.getProducts();
        final _result = _response.fold((l) => l, (r) => r);

        expect(_result, isA<ServerFailure>());
      });

      test('Should delete product then return a String msg', () async {
        final _fixture = responseProduct;
        final _fakeProduct = fakeProduct;

        when(dataSource.deleteProduct(_fakeProduct))
            .thenAnswer((_) async => "Produto deletado com sucesso");

        final _response = await repository.deleteProduct(_fakeProduct);
        final _result = _response.fold((l) => l, (r) => r);
        expect(_result, 'Produto deletado com sucesso');
        expect(_result, isA<String>());
      });
      test('Should create product then return a ProductEntity', () async {
        final _fixture = fakeProduct;
        final _fakeProductModel = fakeProductModel;

        when(dataSource.createProduct(_fakeProductModel))
            .thenAnswer((_) async => _fixture);

        final _response = await repository.createProduct(_fakeProductModel);
        final _result = _response.fold((l) => l, (r) => r);
        // expect(_result);
        expect(_result, isA<ProductEntity>());
      });
    },
  );
}
