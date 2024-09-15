import 'package:enxolist/data/models/auth/response/user_DTO.dart';
import 'package:enxolist/data/services/auth/auth_service.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/presentation/page-navigator/controller/page_navigator_controller.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../../infra/utils/store.dart';

part 'profile_controller.g.dart';

@lazySingleton
class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  final auth = getIt<AuthService>();
  final navigator = getIt<PageNavigatorController>();

  @observable
  UserDTO? userCouple;

  @observable
  int selectedImageProfile = 0;

  @action
  Future<void> getUser(String coupleId) async {
    userCouple = await auth.getCoupleUser(coupleId);
  }

  @action
  void changeSelectedImageProfile(int i) {
    selectedImageProfile = i;
    StoreData.saveString('avatarIndex', selectedImageProfile.toString());
  }

  @action
  Future<void> acceptCouple(
      {required String coupleID, required String userID}) async {
    await auth.acceptCoupleUser(coupleId: coupleID, userID: userID);
  }

  @action
  void logout() {
    auth.logout();
    navigator.changeToPage(0);
  }
}
