import 'package:enxolist/data/models/notification/notification_dto.dart';
import 'package:enxolist/presentation/pages/notification/controller/notification_controller.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  NotificationDTO notification;
  NotificationController controller;
  NotificationCard(
      {required this.notification, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListTile(
        leading: Text(
            "${notification.toUserName} deseja entrar em um relacionamento com você, deseja aceitar?"),
      ),
    );
  }
}
