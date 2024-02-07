import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/clients/http_clients.dart';
import 'package:enxolist/data/data_source/product_remote_datasource.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeResponse<T> extends Fake implements Response<T> {}

class _FakeProductResponse<L, R> extends Fake implements ProductResponse {}

class _FakeAuthResponse<UserResponse> extends Fake
    implements Response<UserResponse> {}

class Diomock extends Mock implements Dio {}

class SharedPreferencesMock extends Mock implements SharedPreferences {}

class HttpClientAppMock extends Mock implements HttpClientApp {
  @override
  Future<Response> getMethod(String endpoint) =>
      super.noSuchMethod(Invocation.method(#getMethod, [endpoint]),
          returnValue: Future.value(_FakeResponse()));

  @override
  Future<Response> login(AuthRequest request) =>
      super.noSuchMethod(Invocation.method(#login, [request]),
          returnValue: Future.value(_FakeAuthResponse()));
}

class ProductDataSourceMock extends Mock implements IProductDataSource {
// getProducts

  @override
  Future<ProductResponse> getProducts() =>
      super.noSuchMethod(Invocation.method(#getProducts, []),
          returnValue: Future.value(_FakeProductResponse()));
}
