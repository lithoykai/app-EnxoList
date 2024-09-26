import 'package:dartz/dartz.dart';
import 'package:enxolist/domain/use-cases/notification/get_notification_count_usecase.dart';
import 'package:enxolist/domain/use-cases/notification/get_notification_usecase.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:enxolist/presentation/pages/notification/controller/notification_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/notification_fixture.dart';
import 'notification_controller_test.mocks.dart';

@GenerateMocks([GetNotificationUsecase, GetNotificationCountUsecase])
void main() {
  late GetNotificationUsecase useCase;
  late NotificationController controller;
  late GetNotificationCountUsecase mockUseCase;

  setUp(() {
    useCase = MockGetNotificationUsecase();
    mockUseCase = MockGetNotificationCountUsecase();
    controller = NotificationController(
        getNotificationUsecase: useCase,
        getNotificationCountUseCase: mockUseCase);
  });

  group('Notification Controller tests', () {
    test('Should return a list of notifications successfully', () async {
      final _fakeNotificationDTOList = fakeNotificationDTOList;
      when(useCase.call('idUser'))
          .thenAnswer((_) async => Right(_fakeNotificationDTOList));

      final _response = await controller.getNotifications('idUser');

      expect(controller.notifications.isNotEmpty, true);
      expect(controller.state, isA<NotificationStateIdle>());
    });
    test('Should return a error state', () async {
      when(useCase.call('idUser')).thenAnswer((_) async => Left(ServerFailure(
          msg: 'Ocorreu um erro no servidor ao obter as notificações.')));

      final _response = await controller.getNotifications('idUser');

      expect(controller.state, isA<NotificationStateError>());
    });
  });
}
