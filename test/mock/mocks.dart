import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/clients/http_client.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeResponse<T> extends Fake implements Response<T> {}

class _FakeProductResponse<L, R> extends Fake implements ProductResponse {}

class _FakeProductEntity<L, R> extends Fake implements ProductEntity {}

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
  Future<Response> post(String endpoint, Map<String, dynamic> data) =>
      super.noSuchMethod(Invocation.method(#post, [endpoint, data]),
          returnValue: Future.value(_FakeResponse()));

  @override
  Future<Response> login(AuthRequest request) =>
      super.noSuchMethod(Invocation.method(#login, [request]),
          returnValue: Future.value(_FakeAuthResponse()));
  @override
  Future<Response> delete(String endpoint) =>
      super.noSuchMethod(Invocation.method(#delete, [endpoint]),
          returnValue: Future.value(_FakeResponse()));
}
