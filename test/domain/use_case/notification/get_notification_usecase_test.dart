import 'package:dartz/dartz.dart';
import 'package:enxolist/data/models/notification/notification_dto.dart';
import 'package:enxolist/data/repositories/notification/notification_repository_impl.dart';
import 'package:enxolist/domain/repositories/notification_repository.dart';
import 'package:enxolist/domain/use-cases/notification/get_notification_usecase.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/notification_fixture.dart';
import 'get_notification_usecase_test.mocks.dart';

@GenerateMocks([NotificationRepositoryImpl])
void main() {
  late NotificationRepository repository;
  late GetNotificationUsecase useCase;

  setUp(() {
    repository = MockNotificationRepositoryImpl();
    useCase = GetNotificationUsecase(repository: repository);
  });

  group('Get Notification UseCase Tests', () {
    test('Should return a list of notifications successfully', () async {
      final _fakeNotificationDTOList = fakeNotificationDTOList;
      when(repository.getNotifications('idUser'))
          .thenAnswer((_) async => Right(_fakeNotificationDTOList));

      final _response = await useCase.call('idUser');
      final _result = _response.fold((l) => l, (r) => r);

      expect(_result, isA<List<NotificationDTO>>());
      expect((_result as List<NotificationDTO>).isNotEmpty, true);
    });
    test('Should return a AppFailure error', () async {
      final _fakeNotificationDTOList = fakeNotificationDTOList;

      when(repository.getNotifications('idUser'))
          .thenAnswer((_) async => Left(AppFailure()));

      final _response = await useCase.call('idUser');
      final _result = _response.fold((l) => l, (r) => r);

      expect(_result, isA<AppFailure>());
    });
  });
}
