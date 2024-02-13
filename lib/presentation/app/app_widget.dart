import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/infra/utils/approuter.dart';
import 'package:enxolist/presentation/app/app_config.dart';
import 'package:enxolist/presentation/auth/auth_page.dart';
import 'package:enxolist/presentation/pages/auth_or_home.dart';
import 'package:enxolist/presentation/pages/categories/category/category_list_page.dart';
import 'package:enxolist/presentation/pages/categories/category/product/product_detail.dart';
import 'package:enxolist/presentation/pages/categories/forms/product_form_page.dart';
import 'package:enxolist/presentation/pages/profile/config/app_config_page.dart';
import 'package:enxolist/presentation/pages/profile/forms/change_user_info.dart';
import 'package:enxolist/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
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
        print(failure.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EnxoList',
      theme: ThemeData(
        // fontFamily: "JustMeAgainDownHere",
        colorScheme: ColorScheme.fromSeed(
          primary: ColorsTheme.primaryColor,
          seedColor: const Color(0xFFE36F6F),
          onPrimary: ColorsTheme.primaryColorLight,
          background: ColorsTheme.background,
          outline: ColorsTheme.backgroundForm,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              color: ColorsTheme.primaryColor,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold
              // fontSize: 24,
              ),
          bodyLarge: TextStyle(
            color: ColorsTheme.textColor,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w300,
          ),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRouter.AUTH_OR_HOME: (context) => const AuthOrHomePage(),
        AppRouter.SPLASH_PAGE: (context) => const SplashPage(),
        AppRouter.AUTH_PAGE: (context) => const AuthPage(),
        AppRouter.CHANGE_USER_INFO: (context) => const ChangeUserInfo(),
        AppRouter.APP_CONFIG_PAGE: (context) => const AppConfigPage(),
        AppRouter.CATEGORY_LIST: (context) => CategoryListPage(),
        AppRouter.PRODUCT_FORM_PAGE: (context) => const ProductFormPage(),
        AppRouter.PRODUCT_DETAIL: (context) => const ProductDetail(),
      },
    );
  }
}
