import 'package:dartz/dartz.dart';
import 'package:enxolist/data/models/notification/notification_dto.dart';
import 'package:enxolist/domain/repositories/notification_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationUsecase {
  final NotificationRepository _notificationRepository;

  GetNotificationUsecase({required NotificationRepository repository})
      : _notificationRepository = repository;

  Future<Either<Failure, List<NotificationDTO>>> call(String idUser) async {
    return await _notificationRepository.getNotifications(idUser);
  }
}
