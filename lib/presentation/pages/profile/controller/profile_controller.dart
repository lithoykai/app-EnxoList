import 'package:enxolist/data/services/auth/auth_service.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/presentation/page-navigator/controller/page_navigator_controller.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'profile_controller.g.dart';

@lazySingleton
class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  final auth = getIt<AuthService>();
  final navigator = getIt<PageNavigatorController>();

  @observable
  int selectedImageProfile = 0;

  @action
  void changeSelectedImageProfile(int i) {
    selectedImageProfile = i;
  }

  @action
  void logout() {
    auth.logout();
    navigator.changeToPage(0);
  }
}
