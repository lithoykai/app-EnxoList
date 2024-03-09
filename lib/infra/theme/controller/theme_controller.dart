import 'package:enxolist/infra/theme/default_theme.dart';
import 'package:enxolist/infra/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_controller.g.dart';

@singleton
class ThemeController = _ThemeControllerBase with _$ThemeController;

abstract class _ThemeControllerBase with Store {
  _ThemeControllerBase() {
    loadTheme();
  }

  @observable
  ThemeData themeData = lightTheme;

  @computed
  bool get isDark => themeData.brightness == Brightness.dark;

  @action
  void changeTheme() {
    if (isDark) {
      themeData = lightTheme;
    } else {
      themeData = darkTheme;
    }
    StoreData.saveBool('isDark', isDark);
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // await Future.delayed(Duration(seconds: 1));
    if (prefs.containsKey('isDark') && prefs.getBool('isDark')!) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }
  }
}
