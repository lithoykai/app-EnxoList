import 'package:enxolist/data/models/notification/notification_dto.dart';
import 'package:enxolist/domain/use-cases/notification/get_notification_count_usecase.dart';
import 'package:enxolist/domain/use-cases/notification/get_notification_usecase.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'notification_controller.g.dart';

@lazySingleton
class NotificationController = _NotificationControllerBase
    with _$NotificationController;

abstract class _NotificationControllerBase with Store {
  final GetNotificationUsecase _getNotificationUsecase;
  final GetNotificationCountUsecase _getNotificationCountUsecase;

  _NotificationControllerBase(
      {required GetNotificationUsecase getNotificationUsecase,
      required GetNotificationCountUsecase getNotificationCountUseCase})
      : _getNotificationUsecase = getNotificationUsecase,
        _getNotificationCountUsecase = getNotificationCountUseCase;

  @observable
  List<NotificationDTO> notifications = ObservableList.of([]);
  @observable
  NotificationState state = NotificationStateIdle();
  @observable
  int count = 0;

  @action
  Future<void> getNotificationCount(String user) async {
    state = NotificationStateLoading();
    final _response = await _getNotificationCountUsecase.call(user);
    _response.fold((l) {
      if (l is ServerFailure) {
        state = NotificationStateError(l.msg!);
      } else {
        l as AppFailure;
        NotificationStateError(l.msg!);
      }
    }, (r) {
      count = r;
      state = NotificationStateIdle();
    });
  }

  @action
  Future<void> getNotifications(String user) async {
    state = NotificationStateLoading();
    final _response = await _getNotificationUsecase.call(user);
    _response.fold((l) {
      if (l is ServerFailure) {
        state = NotificationStateError(l.msg!);
      } else {
        l as AppFailure;
        NotificationStateError(l.msg!);
      }
    }, (r) {
      notifications = ObservableList.of(r);
      state = NotificationStateIdle();
    });
  }
}

class NotificationState {}

class NotificationStateLoading extends NotificationState {}

class NotificationStateError extends NotificationState {
  final String message;

  NotificationStateError(this.message);
}

class NotificationStateSucess extends NotificationState {}

class NotificationStateIdle extends NotificationState {}
