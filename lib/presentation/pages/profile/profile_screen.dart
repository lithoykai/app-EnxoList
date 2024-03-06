import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/presentation/pages/profile/controller/profile_controller.dart';
import 'package:enxolist/presentation/pages/profile/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showListView = false;
  late var box;
  late UserResponse? user;
  @override
  void initState() {
    super.initState();
    if (Hive.isBoxOpen('userData')) {
      var box = Hive.box('userData');
      user = box.get('userData');
    }
    // var box = Hive.box<UserResponse>('userData');
  }

  showList() {
    setState(() {
      _showListView = !_showListView;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = getIt<ProfileController>();

    return Container(
      color: ColorsTheme.background,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: _showListView ? 48 : 40,
              child: Container(
                  color: Colors.amber,
                  child: ProfileAvatar(user: user!, showList: showList)),
            ),
            Expanded(
                flex: _showListView ? 20 : 45,
                child: Column(
                  children: [
                    const Divider(),
                    TextButton(
                      onPressed: controller.logout,
                      child: const Text(
                        'Desconectar da conta',
                        style: TextStyle(color: ColorsTheme.textColor),
                      ),
                    ),
                    const Divider(),
                  ],
                )),
            const Text(
              'Version: 0.1.1',
              style: TextStyle(color: ColorsTheme.textColor),
            )
          ],
        ),
      ),
    );
  }
}
