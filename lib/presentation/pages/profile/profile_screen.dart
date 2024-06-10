import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/infra/theme/controller/theme_controller.dart';
import 'package:enxolist/presentation/pages/profile/controller/profile_controller.dart';
import 'package:enxolist/presentation/pages/profile/widgets/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final themeController = getIt<ThemeController>();
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
    final height2 = (height * _flex1 * 2.1) / total;
    final height3 = (height * _flex3 * 0.9) / total;

    return SafeArea(
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: _showListView ? height3 : height2,
            child: ProfileAvatar(user: user!, showList: showList),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: _showListView ? height2 : height4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Divider(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  TextButton.icon(
                    icon: Icon(
                      themeController.isDark
                          ? Icons.light_mode
                          : Icons.dark_mode,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    onPressed: () => themeController.changeTheme(),
                    label: Text(
                      themeController.isDark ? 'Modo claro' : 'Modo escuro',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  TextButton.icon(
                    icon: Icon(
                      FontAwesomeIcons.instagram,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    onPressed: () => launchUrl(
                        Uri.parse("https://bit.ly/enxolist"),
                        mode: LaunchMode.externalApplication),
                    label: Text(
                      'Siga-nos no Instagram',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  TextButton.icon(
                    icon: Icon(
                      Icons.logout,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    onPressed: controller.logout,
                    label: Text(
                      'Desconectar da conta',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
