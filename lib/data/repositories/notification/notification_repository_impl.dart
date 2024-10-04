import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/notification/notification_remote_datasource.dart';
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
    } on DioException catch (e) {
      return left(ServerFailure(
          msg: 'Ocorreu um erro no servidor ao obter as notificações.'));
    } on Exception catch (e) {
      return left(AppFailure(
          msg: 'Ocorreu um erro desconhecido na obtenção das notificações.'));
    }
  }

  @override
  Future<Either<Failure, int>> getNotificationCount(String user) async {
    try {
      final _response = await _datasource.getNotificationCount(user);
      return right(_response);
    } on DioException catch (e) {
      return left(ServerFailure(
          msg: 'Ocorreu um erro no servidor ao obter as notificações.'));
    } on Exception catch (e) {
      return left(AppFailure(
          msg: 'Ocorreu um erro desconhecido na obtenção das notificações.'));
    }
  }
}
