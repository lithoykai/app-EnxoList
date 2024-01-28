import 'package:enxolist/data/services/auth/auth_service.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = getIt<AuthService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Um teste!'),
            Observer(
              builder: (_) => TextButton(
                  onPressed: () {
                    auth.logout();
                  },
                  child: Text('Logout')),
            )
          ],
        ),
      ),
    );
  }
}
