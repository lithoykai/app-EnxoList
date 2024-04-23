// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CostController on _CostControllerBase, Store {
  late final _$listAsyncAction =
      AsyncAction('_CostControllerBase.list', context: context);

  @override
  Future<void> list() {
    return _$listAsyncAction.run(() => super.list());
  }

  late final _$_CostControllerBaseActionController =
      ActionController(name: '_CostControllerBase', context: context);

  @override
  void setValues(List<CostValuesModel> list) {
    final _$actionInfo = _$_CostControllerBaseActionController.startAction(
        name: '_CostControllerBase.setValues');
    try {
      return super.setValues(list);
    } finally {
      _$_CostControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
