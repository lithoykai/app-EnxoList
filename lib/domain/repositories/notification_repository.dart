import 'package:dartz/dartz.dart';
import 'package:enxolist/data/models/notification/notification_dto.dart';
import 'package:enxolist/infra/failure/failure.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<NotificationDTO>>> getNotifications(String user);

  Future<Either<Failure, String>> deleteNotification(String id);

  Future<Either<Failure, NotificationDTO>> createNotification(
      NotificationDTO notification);

  Future<Either<Failure, int>> getNotificationCount(String user);
}
