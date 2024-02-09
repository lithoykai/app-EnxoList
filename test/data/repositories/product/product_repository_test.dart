import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/product_remote_datasource.dart';
import 'package:enxolist/data/repositories/product/product_repository_impl.dart';
import 'package:enxolist/domain/repositories/product_repository.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/product_fixture.dart';
import '../../../mock/mocks.dart';

void main() {
  late IProductRepository repository;
  late IProductDataSource dataSource;

  setUp(() {
    dataSource = ProductDataSourceMock();
    repository = ProductRepositoryImpl(dataSouce: dataSource);
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

      test('When try get list products then either left ServerFailure',
          () async {
        when(dataSource.getProducts()).thenThrow((_) async => Exception());

        final _response = await repository.getProducts();
        final _result = _response.fold((l) => l, (r) => r);

        expect(_result, isA<ServerFailure>());
      });

      test('Should delete product then return a String msg', () async {
        final _fixture = responseProduct;
        final _fakeProduct = fakeProduct;

        when(dataSource.deleteProduct(_fakeProduct)).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
            data: {"msg": "Produto deletado com sucesso"},
          ),
        );

        final _response = await repository.deleteProduct(_fakeProduct);
        final _result = _response.fold((l) => l, (r) => r);
        expect(_result, 'Produto deletado com sucesso');
        expect(_result, isA<String>());
      });
    },
  );
}
