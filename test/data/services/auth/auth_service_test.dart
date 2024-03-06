import 'package:dio/dio.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/data/services/auth/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/auth_fixture.dart';
import '../../../mock/mocks.dart';
import '../../datasource/product/product_datasource_test.mocks.dart';
import 'auth_service_test.mocks.dart';

@GenerateMocks([
  Box,
  HiveInterface,
])
void main() {
  group('AuthService', () {
    late AuthService authService;
    late MockHttpClientApp httpClientMock;

    late Dio dio;
    late MockHiveInterface mockHiveInterface;
    late MockBox mockHiveBox;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();

      // await Hive.initFlutter();
      Hive.registerAdapter(UserResponseAdapter());

      dio = Diomock();
      mockHiveInterface = MockHiveInterface();
      mockHiveBox = MockBox();
      httpClientMock = MockHttpClientApp();
      authService = AuthService(http: httpClientMock, hive: mockHiveInterface);
    });

    test('Should try register and return a right', () async {
      final request = authRegister;
      final _fakeUserHttpResponse = fakeUserHttpResponse;

      when(httpClientMock.register(request)).thenAnswer((_) async => Response(
            statusCode: 200,
            data: _fakeUserHttpResponse,
            requestOptions: RequestOptions(),
          ));
      when(mockHiveBox.clear()).thenAnswer((_) async => Future.value(0));
      when(mockHiveInterface.isBoxOpen('userData')).thenAnswer((_) => false);
      when(mockHiveInterface.openBox('userData'))
          .thenAnswer((_) async => mockHiveBox);

      final _response = await authService.authenticate(request);

      expect(
        _response,
        isA<UserResponse>(),
      );
      expect(_response.id.isNotEmpty, true);
    });

    test('When try to authenticate and request fails then return AuthException',
        () async {
      final request = authRequest;
      when(httpClientMock.login(request)).thenThrow(Exception());
      when(mockHiveInterface.isBoxOpen('userData')).thenAnswer((_) => false);
      when(mockHiveInterface.openBox('userData'))
          .thenAnswer((_) async => mockHiveBox);

      final _response = await authService.authenticate(request);
      expect(_response, isA<Exception>());
      // expect(_response.fold((l) => l, (r) => null), isA<AuthException>());
    });
  });
}
