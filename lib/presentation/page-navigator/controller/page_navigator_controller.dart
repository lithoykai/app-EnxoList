import 'package:enxolist/infra/constants/page_navigator_mapper.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'page_navigator_controller.g.dart';

@singleton
class PageNavigatorController = _PageNavigatorControllerBase
    with _$PageNavigatorController;

abstract class _PageNavigatorControllerBase with Store {
  @observable
  int selectedPage = PageNavigatorMapper.categories;

  @action
  void changeToPage(int page) {
    selectedPage = page;
  }
}
