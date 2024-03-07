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
  final controller = getIt<ProfileController>();
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
  }

  showList() {
    setState(() {
      _showListView = !_showListView;
    });
  }

  @override
  Widget build(BuildContext context) {
    int _flex1 = 1, _flex2 = 2, _flex3 = 3;
    final total = _flex1 + _flex2 + _flex3;
    final height = MediaQuery.of(context).size.height;
    final height4 = (height * _flex2 * 1.2) / total;
    final height1 = (height * _flex1) / total;
    final height3 = (height * _flex3 * 1.05) / total;

    return Container(
      color: ColorsTheme.background,
      child: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: _showListView ? height3 : height4,
              child: ProfileAvatar(user: user!, showList: showList),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: _showListView ? height1 : height1,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
