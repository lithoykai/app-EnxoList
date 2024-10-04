import 'package:dartz/dartz.dart';
import 'package:enxolist/domain/repositories/notification_repository.dart';
import 'package:enxolist/domain/use-cases/notification/get_notification_count_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_notification_usecase_test.mocks.dart';

void main() {
  late NotificationRepository repository;
  late GetNotificationCountUsecase useCase;

  setUp(() {
    repository = MockNotificationRepositoryImpl();
    useCase = GetNotificationCountUsecase(repository);
  });

  test('Should return a number', () async {
    when(repository.getNotificationCount('idUser'))
        .thenAnswer((_) async => const Right(1));
    final _response = await useCase.call('idUser');
    final _data = _response.fold((l) => l, (r) => r);
    expect(_data, isA<int>());
  });
}
