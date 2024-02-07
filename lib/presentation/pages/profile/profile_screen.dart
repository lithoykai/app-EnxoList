import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/infra/utils/approuter.dart';
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

  @override
  Widget build(BuildContext context) {
    final controller = getIt<ProfileController>();

    return Container(
      color: ColorsTheme.background,
      child: SafeArea(
          child: Column(
        children: [
          const ProfileAvatar(),
          Text(user!.name, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.CHANGE_USER_INFO);
            },
            child: const Text(
              'Alterar informações de usuário',
              style: TextStyle(color: ColorsTheme.textColor),
            ),
          ),
          const Divider(),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.APP_CONFIG_PAGE);
            },
            child: const Text(
              'Configurações do aplicativo',
              style: TextStyle(color: ColorsTheme.textColor),
            ),
          ),
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
    );
  }
}
