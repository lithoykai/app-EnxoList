// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileController on _ProfileControllerBase, Store {
  late final _$userCoupleAtom =
      Atom(name: '_ProfileControllerBase.userCouple', context: context);

  @override
  UserDTO? get userCouple {
    _$userCoupleAtom.reportRead();
    return super.userCouple;
  }

  @override
  set userCouple(UserDTO? value) {
    _$userCoupleAtom.reportWrite(value, super.userCouple, () {
      super.userCouple = value;
    });
  }

  late final _$selectedImageProfileAtom = Atom(
      name: '_ProfileControllerBase.selectedImageProfile', context: context);

  @override
  int get selectedImageProfile {
    _$selectedImageProfileAtom.reportRead();
    return super.selectedImageProfile;
  }

  @override
  set selectedImageProfile(int value) {
    _$selectedImageProfileAtom.reportWrite(value, super.selectedImageProfile,
        () {
      super.selectedImageProfile = value;
    });
  }

  late final _$getUserAsyncAction =
      AsyncAction('_ProfileControllerBase.getUser', context: context);

  @override
  Future<void> getUser(String coupleId) {
    return _$getUserAsyncAction.run(() => super.getUser(coupleId));
  }

  late final _$acceptCoupleAsyncAction =
      AsyncAction('_ProfileControllerBase.acceptCouple', context: context);

  @override
  Future<void> acceptCouple(
      {required String coupleID, required String userID}) {
    return _$acceptCoupleAsyncAction
        .run(() => super.acceptCouple(coupleID: coupleID, userID: userID));
  }

  late final _$_ProfileControllerBaseActionController =
      ActionController(name: '_ProfileControllerBase', context: context);

  @override
  void changeSelectedImageProfile(int i) {
    final _$actionInfo = _$_ProfileControllerBaseActionController.startAction(
        name: '_ProfileControllerBase.changeSelectedImageProfile');
    try {
      return super.changeSelectedImageProfile(i);
    } finally {
      _$_ProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void logout() {
    final _$actionInfo = _$_ProfileControllerBaseActionController.startAction(
        name: '_ProfileControllerBase.logout');
    try {
      return super.logout();
    } finally {
      _$_ProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userCouple: ${userCouple},
selectedImageProfile: ${selectedImageProfile}
    ''';
  }
}
