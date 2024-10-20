import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:site_bi/data/services/auth_service.dart';
import 'package:site_bi/di/injectable.dart';
import 'package:site_bi/presentation/web/pages/auth/auth_page.dart';
import 'package:site_bi/presentation/web/pages/home/home_page.dart';

class AuthOrHome extends StatelessWidget {
  const AuthOrHome({Key? key});

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
            return auth.isAuth ? HomePage() : const AuthPage();
          });
        }
      },
    );
  }
}
