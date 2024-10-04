// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationController on _NotificationControllerBase, Store {
  late final _$notificationsAtom =
      Atom(name: '_NotificationControllerBase.notifications', context: context);

  @override
  List<NotificationDTO> get notifications {
    _$notificationsAtom.reportRead();
    return super.notifications;
  }

  @override
  set notifications(List<NotificationDTO> value) {
    _$notificationsAtom.reportWrite(value, super.notifications, () {
      super.notifications = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_NotificationControllerBase.state', context: context);

  @override
  NotificationState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(NotificationState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$countAtom =
      Atom(name: '_NotificationControllerBase.count', context: context);

  @override
  int get count {
    _$countAtom.reportRead();
    return super.count;
  }

  @override
  set count(int value) {
    _$countAtom.reportWrite(value, super.count, () {
      super.count = value;
    });
  }

  late final _$getNotificationCountAsyncAction = AsyncAction(
      '_NotificationControllerBase.getNotificationCount',
      context: context);

  @override
  Future<void> getNotificationCount(String user) {
    return _$getNotificationCountAsyncAction
        .run(() => super.getNotificationCount(user));
  }

  late final _$getNotificationsAsyncAction = AsyncAction(
      '_NotificationControllerBase.getNotifications',
      context: context);

  @override
  Future<void> getNotifications(String user) {
    return _$getNotificationsAsyncAction
        .run(() => super.getNotifications(user));
  }

  @override
  String toString() {
    return '''
notifications: ${notifications},
state: ${state},
count: ${count}
    ''';
  }
}
