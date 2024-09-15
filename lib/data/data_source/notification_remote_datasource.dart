import 'package:enxolist/data/models/notification/notification_dto.dart';

abstract class INotificationRemoteDataSource {
  Future<List<NotificationDTO>> getNotifications(String user);

  Future<String> deleteNotification(String id);

  Future<NotificationDTO> createNotification(NotificationDTO notification);
}
