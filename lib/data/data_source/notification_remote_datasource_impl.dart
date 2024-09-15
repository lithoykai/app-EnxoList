import 'package:enxolist/data/data_source/clients/http_client.dart';
import 'package:enxolist/data/data_source/notification_remote_datasource.dart';
import 'package:enxolist/data/models/notification/notification_dto.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: INotificationRemoteDataSource)
class NotificationRemoteDatasourceImpl
    implements INotificationRemoteDataSource {
  HttpClientApp _http;

  NotificationRemoteDatasourceImpl({required HttpClientApp http})
      : _http = http;

  @override
  Future<NotificationDTO> createNotification(
      NotificationDTO notification) async {
    try {
      final response = await _http.post(
        Endpoints.notification,
        notification.toJson(),
      );

      final data = NotificationDTO.fromJson(response.data);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteNotification(String id) {
    // TODO: implement deleteNotification
    throw UnimplementedError();
  }

  @override
  Future<List<NotificationDTO>> getNotifications(String user) async {
    try {
      final response =
          await _http.getMethod("${Endpoints.notification}?user=$user");

      List<NotificationDTO> data = (response.data as List)
          .map((json) => NotificationDTO.fromJson(json))
          .toList();

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
