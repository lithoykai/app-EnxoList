import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/presentation/pages/notification/controller/notification_controller.dart';
import 'package:enxolist/presentation/pages/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final controller = getIt<NotificationController>();
  final profileController = getIt<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Notificações'),
      ),
      body: Observer(builder: (context) {
        if (controller.state is NotificationStateError) {
          return const Center(
              child: Text('Ocorreu um erro ao obter as notificações.'));
        } else if (controller.state is NotificationStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.count == 0) {
          return const Center(child: Text('Nenhuma notificação encontrada.'));
        }
        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(ThemeConstants.padding),
                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color:
                          Theme.of(context).colorScheme.surface.withAlpha(800),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: ThemeConstants.padding,
                        vertical: ThemeConstants.padding),
                    child: Observer(builder: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${notification.toUserName} quer lhe convidar para um relacionamento. Deseja aceitar? ',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Observer(builder: (context) {
                            return profileController.state
                                    is ProfileStateLoading
                                ? const SizedBox(
                                    height: 30,
                                    child: CircularProgressIndicator())
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          profileController
                                              .acceptCouple(
                                                  coupleID: notification.toUser,
                                                  userID:
                                                      notification.ownerUser)
                                              .then((_) async =>
                                                  await controller
                                                      .getNotifications(
                                                          notification.toUser)
                                                      .then((_) => controller
                                                          .notifications
                                                          .remove(
                                                              notification)));
                                        },
                                        child: const Text(
                                          'Aceitar',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // profileController.refuseCouple(
                                          //     coupleID: notification.toUser,
                                          //     userID: notification.ownerUser);
                                        },
                                        child: const Text('Rejeitar',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  );
                          }),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
