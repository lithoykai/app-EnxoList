import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/clients/http_client.dart';
import 'package:enxolist/data/data_source/notification/notification_remote_datasource_impl.dart';
import 'package:enxolist/data/models/notification/notification_dto.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/notification_fixture.dart';
import '../../../mock/mocks.dart';
import '../product/product_datasource_test.mocks.dart';

@GenerateMocks([HttpClientApp])
void main() {
  late Dio dio;
  late MockHttpClientApp httpClientMock;
  late NotificationRemoteDatasourceImpl dataSource;

  setUp(() {
    dio = Diomock();
    httpClientMock = MockHttpClientApp();
    dataSource = NotificationRemoteDatasourceImpl(http: httpClientMock);
  });

  group('Notification tests', () {
    test('Should return a list of notication sucessfully', () async {
      final _fakeHttpResponse = fakeNotificationHttpResponse;

      when(httpClientMock.getMethod('${Endpoints.notification}?user=idUser'))
          .thenAnswer((_) async => Response(
              data: _fakeHttpResponse, requestOptions: RequestOptions()));

      List<NotificationDTO> datasourceResult =
          await dataSource.getNotifications('idUser');
      expect(datasourceResult, isA<List<NotificationDTO>>());
      expect(datasourceResult.isNotEmpty, true);
      expect(datasourceResult[0].id, fakeNotificationHttpResponse[0]['id']);
    });
    test('Should return a empty list', () async {
      final _fakeHttpResponse = [];

      when(httpClientMock.getMethod('${Endpoints.notification}?user=idUser'))
          .thenAnswer((_) async => Response(
              data: _fakeHttpResponse, requestOptions: RequestOptions()));

      List<NotificationDTO> datasourceResult =
          await dataSource.getNotifications('idUser');
      expect(datasourceResult, isA<List<NotificationDTO>>());
      expect(datasourceResult.isEmpty, true);
    });
    test('Should return a error', () async {
      when(httpClientMock.getMethod('${Endpoints.notification}?user=idUser'))
          .thenThrow(Exception());

      expect(() async => await dataSource.getNotifications('idUser'),
          throwsA(isA<Exception>()));
    });
    test('Should return a DIO error', () async {
      when(httpClientMock.getMethod('${Endpoints.notification}?user=idUser'))
          .thenThrow(DioException(requestOptions: RequestOptions()));

      expect(() async => await dataSource.getNotifications('idUser'),
          throwsA(isA<DioException>()));
    });

    test('Should return a number', () async {
      when(httpClientMock
              .getMethod('${Endpoints.notification}/count?user=idUser'))
          .thenAnswer((_) async =>
              Response(data: {'count': 1}, requestOptions: RequestOptions()));

      int datasourceResult = await dataSource.getNotificationCount('idUser');
      expect(datasourceResult, isA<int>());
    });
  });
}
