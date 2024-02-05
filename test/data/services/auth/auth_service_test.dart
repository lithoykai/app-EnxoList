import 'package:dio/dio.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/data/services/auth/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/auth_fixture.dart';
import '../../../mock/mocks.dart';

void main() {
  group('AuthService', () {
    late AuthService authService;
    late HttpClientAppMock httpClientMock;
    late Dio dio;

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      dio = Diomock();

      httpClientMock = HttpClientAppMock();
      authService = AuthService(http: httpClientMock);
    });

    test('When try authenticate return a right UserResponse', () async {
      final request = authRequest;
      final _fakeUserHttpResponse = fakeUserHttpResponse;

      when(httpClientMock.login(request)).thenAnswer((_) async => Response(
            statusCode: 200,
            data: _fakeUserHttpResponse,
            requestOptions: RequestOptions(),
          ));

      final _response = await authService.authenticate(request);
      expect(
          _response.fold((failure) => failure, (userResponse) => userResponse),
          isA<UserResponse>());
    });

    test('When try authenticate then either left AuthException', () async {
      final request = authRequest;
      when(httpClientMock.login(request)).thenAnswer((_) async => Response(
            statusCode: 401,
            requestOptions: RequestOptions(),
            data: {'detail': 'Credenciais inválidas'},
          ));

      final result = await authService.authenticate(request);

      expect(result.isLeft(), true);
    });
  });
}
