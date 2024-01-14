import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/clients/http_clients.dart';
import 'package:enxolist/data/data_source/product_remote_datasource.dart';
import 'package:enxolist/domain/entities/product/user.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:mockito/mockito.dart';

class _FakeResponse<T> extends Fake implements Response<T> {}

class _FakeProductResponse<L, R> extends Fake implements ProductResponse {}

class Diomock extends Mock implements Dio {}

class HttpClientAppMock extends Mock implements HttpClientApp {
  @override
  Future<Response> getMethod(String endpoint) =>
      super.noSuchMethod(Invocation.method(#getMethod, [endpoint]),
          returnValue: Future.value(_FakeResponse()));
  @override
  Future<Response> getTokenLogin(User user, String password, String endpoint) =>
      super.noSuchMethod(
          Invocation.method(#getTokenLogin, [user, password, endpoint]),
          returnValue: Future.value(_FakeResponse()));
}

class ProductDataSourceMock extends Mock implements IProductDataSource {
// getProducts

  @override
  Future<ProductResponse> getProducts() =>
      super.noSuchMethod(Invocation.method(#getProducts, []),
          returnValue: Future.value(_FakeProductResponse()));
}

  // @override
  // Future<Either<Failure, ProductResponse>> getProducts() =>
  //     super.noSuchMethod(Invocation.method(#getProducts, []),
  //         returnValue:
  //             Future.value(_FakeResponseEither<Failure, ProductResponse>()));