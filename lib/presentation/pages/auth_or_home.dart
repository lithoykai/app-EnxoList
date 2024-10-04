import 'package:enxolist/data/services/auth/auth_service.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/infra/utils/store.dart';
import 'package:enxolist/presentation/auth/auth_page.dart';
import 'package:enxolist/presentation/page-navigator/page_navigator.dart';
import 'package:enxolist/presentation/pages/onboarding/onboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AuthOrHomePage extends StatefulWidget {
  const AuthOrHomePage({Key? key});

  @override
  State<AuthOrHomePage> createState() => _AuthOrHomePageState();
}

class _AuthOrHomePageState extends State<AuthOrHomePage> {
  bool? onboardPage;
  bool? offlineMode;

  void seenPage() async {
    onboardPage = await StoreData.getBool('onboardPage') ?? false;
    offlineMode = await StoreData.getBool('offlineMode') ?? false;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      seenPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = getIt<AuthService>();

    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          return Observer(builder: (context) {
            if (onboardPage == null || onboardPage == false) {
              return const OnboardPage();
            } else {
              return offlineMode == false
                  ? auth.isAuth
                      ? PageNavigatorScreen()
                      : const AuthPage()
                  : PageNavigatorScreen();
            }
          });
        }
      },
    );
  }
}
