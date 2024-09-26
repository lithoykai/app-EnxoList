import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/notification/notification_remote_datasource.dart';
import 'package:enxolist/data/data_source/notification/notification_remote_datasource_impl.dart';
import 'package:enxolist/data/models/notification/notification_dto.dart';
import 'package:enxolist/data/repositories/notification/notification_repository_impl.dart';
import 'package:enxolist/domain/repositories/notification_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/notification_fixture.dart';
import 'notification_repository_test.mocks.dart';

@GenerateMocks([NotificationRemoteDatasourceImpl])
void main() {
  late INotificationRemoteDataSource dataSource;
  late NotificationRepository repository;

  setUp(() {
    dataSource = MockNotificationRemoteDatasourceImpl();
    repository = NotificationRepositoryImpl(datasource: dataSource);
  });

  group('Notification Repository Tests', () {
    test('Should return a list of notifications successfully', () async {
      final _fakeNotificationList = fakeNotificationDTOList;

      when(dataSource.getNotifications('idUser'))
          .thenAnswer((_) async => fakeNotificationDTOList);
      final _response = await repository.getNotifications('idUser');
      final _result = _response.fold((l) => l, (r) => r);
      expect(_result, isA<List<NotificationDTO>>());
    });
  });
  test('Should return a app error', () async {
    when(dataSource.getNotifications('idUser')).thenThrow(() => Exception());
    final _response = await repository.getNotifications('idUser');
    final _result = _response.fold((l) => l, (r) => r);
    expect(_result, isA<AppFailure>());
  });
  test('Should return a server error', () async {
    when(dataSource.getNotifications('idUser'))
        .thenThrow(DioException(requestOptions: RequestOptions()));
    final _response = await repository.getNotifications('idUser');
    final _result = _response.fold((l) => l, (r) => r);
    expect(_result, isA<ServerFailure>());
  });
  test('Should return a number', () async {
    // final _fakeNotificationList = fakeNotificationDTOList;

    when(dataSource.getNotificationCount('idUser')).thenAnswer((_) async => 1);
    final _response = await repository.getNotificationCount('idUser');
    final _result = _response.fold((l) => l, (r) => r);
    expect(_result, isA<int>());
  });
}
