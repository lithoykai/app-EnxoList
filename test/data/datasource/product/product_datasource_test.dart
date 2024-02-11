import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/product_remote_datasource.dart';
import 'package:enxolist/data/data_source/product_remote_datasource_impl.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/product_fixture.dart';
import '../../../mock/mocks.dart';

void main() {
  late Dio dio;
  late HttpClientAppMock httpClientMock;
  late IProductDataSource dataSource;

  setUp(() {
    dio = Diomock();
    httpClientMock = HttpClientAppMock();
    dataSource = ProductDataSourceImpl(http: httpClientMock);
  });

  group('test product datasource', () {
    test(
        'When try get list products then return a ProductResponse with a data list',
        () async {
      final _fakeHttpResponse = fakeProductHttpResponse;

      when(httpClientMock.getMethod(Endpoints.products)).thenAnswer((_) async =>
          Response(data: _fakeHttpResponse, requestOptions: RequestOptions()));
      final _response = await dataSource.getProducts();
      expect(_response, isA<ProductResponse>());
      expect(_response.data.isNotEmpty, true);
      expect(_response.data[0].id, fakeProductHttpResponse[0]['id']);
    });

    test(
        'When try get list products then return a ProductResponse with a empty data list',
        () async {
      final _fakeHttpResponse = [];

      when(httpClientMock.getMethod(Endpoints.products)).thenAnswer((_) async =>
          Response(data: _fakeHttpResponse, requestOptions: RequestOptions()));
      final _response = await dataSource.getProducts();

      expect(_response, isA<ProductResponse>());
      expect(_response.data.isEmpty, true);
    });

    test('Should get list products then throw a Exception', () async {
      when(httpClientMock.getMethod(Endpoints.products)).thenThrow(Exception());

      expect(() async => await dataSource.getProducts(),
          throwsA(isA<Exception>()));
    });
  });

  test('Should delete product then return a Response with a data msg',
      () async {
    final _fakeProduct = fakeProduct;

    when(httpClientMock.delete('${Endpoints.deleteProduct}/${fakeProduct.id}'))
        .thenAnswer((_) async => Response(
            data: {"msg": "Produto deletado com sucesso"},
            requestOptions: RequestOptions()));
    final _response = await dataSource.deleteProduct(fakeProduct);
    expect(_response, isA<Response>());
    expect(_response.data.isNotEmpty, true);
    expect(_response.data["msg"], 'Produto deletado com sucesso');
  });
}
