import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/infra/theme/controller/theme_controller.dart';
import 'package:enxolist/infra/utils/approuter.dart';
import 'package:enxolist/presentation/app/app_config.dart';
import 'package:enxolist/presentation/auth/auth_page.dart';
import 'package:enxolist/presentation/pages/auth_or_home.dart';
import 'package:enxolist/presentation/pages/categories/category_list_page.dart';
import 'package:enxolist/presentation/pages/onboarding/onboard_page.dart';
import 'package:enxolist/presentation/pages/profile/config/app_config_page.dart';
import 'package:enxolist/presentation/pages/profile/forms/change_user_info.dart';
import 'package:enxolist/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  ThemeController controller = getIt<ThemeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _observerFailure();
    });
  }

  @override
  void dispose() {
    AppConfig.instance.onDispose();
    super.dispose();
  }

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ocorreu um erro.'),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Fechar.'))
            ],
          );
        });
  }

  void _observerFailure() {
    AppConfig.instance.streamError.stream.listen((failure) {
      if (failure != null) {
        _showErrorDialog(failure.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.themeData != null) {
      return Observer(builder: (context) {
        return MaterialApp(
          title: 'EnxoList',
          theme: controller.themeData,
          debugShowCheckedModeBanner: false,
          routes: {
            AppRouter.AUTH_OR_HOME: (context) => const AuthOrHomePage(),
            AppRouter.SPLASH_PAGE: (context) => const SplashPage(),
            AppRouter.AUTH_PAGE: (context) => const AuthPage(),
            AppRouter.CHANGE_USER_INFO: (context) => const ChangeUserInfo(),
            AppRouter.APP_CONFIG_PAGE: (context) => const AppConfigPage(),
            AppRouter.CATEGORY_LIST: (context) => CategoryListPage(),
            AppRouter.ONBOARD_PAGE: (context) => OnboardPage(),
            // AppRouter.PRODUCT_FORM_PAGE: (context) => const ProductFormPage(),
            // AppRouter.PRODUCT_DETAIL: (context) => const ProductDetail(),
          },
        );
      });
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
