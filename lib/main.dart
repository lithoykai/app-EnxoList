import 'package:enxolist/infra/utils/approuter.dart';
import 'package:enxolist/pages/auth_page.dart';
import 'package:enxolist/pages/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EnxoListMain());
}

class EnxoListMain extends StatelessWidget {
  const EnxoListMain({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EnxoList',
      theme: ThemeData(
        // fontFamily: "JustMeAgainDownHere",
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE36F6F)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        AppRouter.SPLASH_PAGE: (context) => SplashPage(),
        AppRouter.AUTH_PAGE: (context) => AuthPage(),
      },
    );
  }
}
