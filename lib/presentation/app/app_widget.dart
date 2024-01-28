import 'package:enxolist/infra/utils/approuter.dart';
import 'package:enxolist/presentation/auth/auth_page.dart';
import 'package:enxolist/presentation/pages/auth_or_home.dart';
import 'package:enxolist/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
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
        AppRouter.AUTH_OR_HOME: (context) => const AuthOrHomePage(),
        AppRouter.SPLASH_PAGE: (context) => const SplashPage(),
        AppRouter.AUTH_PAGE: (context) => const AuthPage(),
      },
    );
  }
}
