import 'package:dartz/dartz.dart';
import 'package:enxolist/data/data_source/notification_remote_datasource.dart';
import 'package:enxolist/data/models/notification/notification_dto.dart';
import 'package:enxolist/domain/repositories/notification_repository.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  INotificationRemoteDataSource _datasource;

  NotificationRepositoryImpl(
      {required INotificationRemoteDataSource datasource})
      : _datasource = datasource;

  @override
  Future<Either<Failure, NotificationDTO>> createNotification(
      NotificationDTO notification) {
    // TODO: implement createNotification
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> deleteNotification(String id) {
    // TODO: implement deleteNotification
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<NotificationDTO>>> getNotifications(
      String user) async {
    try {
      final _response = await _datasource.getNotifications(user);
      return right(_response);
    } catch (e) {
      return left(ServerFailure(msg: 'Erro ao obter lista de notificações'));
    }
  }
}
