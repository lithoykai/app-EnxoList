import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/data/services/auth/auth_service.dart';
import 'package:enxolist/infra/failure/auth_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/auth_fixture.dart';
import '../../../mock/mocks.dart';
import 'auth_service_test.mocks.dart';

@GenerateMocks([LazyBox, HiveInterface])
void main() {
  group('AuthService', () {
    late AuthService authService;
    late HttpClientAppMock httpClientMock;
    late Dio dio;
    late MockHiveInterface mockHiveInterface;
    late MockLazyBox mockHiveBox;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();

      // await Hive.initFlutter();
      Hive.registerAdapter(UserResponseAdapter());

      dio = Diomock();
      mockHiveInterface = MockHiveInterface();
      mockHiveBox = MockLazyBox();
      httpClientMock = HttpClientAppMock();
      authService = AuthService(http: httpClientMock, hive: mockHiveInterface);
    });

    test('Should return a right UserResponse', () async {
      final request = authRequest;
      final _fakeUserHttpResponse = fakeUserHttpResponse;

      when(httpClientMock.login(request)).thenAnswer((_) async => Response(
            statusCode: 200,
            data: _fakeUserHttpResponse,
            requestOptions: RequestOptions(),
          ));
      when(mockHiveBox.clear()).thenAnswer((_) async => Future.value(0));
      when(mockHiveInterface.openLazyBox('userData'))
          .thenAnswer((_) async => mockHiveBox);

      final _response = await authService.authenticate(request);

      expect(
        _response.fold((failure) => failure, (userResponse) => userResponse),
        isA<UserResponse>(),
      );
    });

    test('When try authenticate then either left AuthException', () async {
      final request = authRequest;
      when(httpClientMock.login(request)).thenAnswer((_) async => Response(
            statusCode: 401,
            requestOptions: RequestOptions(),
            data: {'detail': 'Credenciais inválidas'},
          ));

      final result = await authService.authenticate(request);

      expect(result, isA<Left<AuthException, UserResponse>>());
      expect(result.fold((failure) => failure.toString(), (userResponse) => ""),
          'Credenciais inválidas');
    });
  });
}
