import 'package:enxolist/data/models/notification/notification_dto.dart';

NotificationDTO fakeNotificationDTO = NotificationDTO(
    id: '1', ownerUser: 'idUser', toUser: 'idUser', toUserName: '');

List<Map<String, dynamic>> fakeNotificationHttpResponse = [
  {
    'id': '1',
    'ownerUser': 'idUser',
    'toUser': 'idUser',
  }
];

List<NotificationDTO> fakeNotificationDTOList = [
  fakeNotificationDTO,
  fakeNotificationDTO
];
