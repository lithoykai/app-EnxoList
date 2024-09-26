import 'package:dartz/dartz.dart';
import 'package:enxolist/domain/repositories/notification_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationCountUsecase {
  final NotificationRepository _notificationRepository;

  GetNotificationCountUsecase(NotificationRepository notificationRepository)
      : _notificationRepository = notificationRepository;

  Future<Either<Failure, int>> call(String idUser) async {
    return await _notificationRepository.getNotificationCount(idUser);
  }
}
