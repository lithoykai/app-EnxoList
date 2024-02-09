import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/presentation/page-navigator/controller/page_navigator_controller.dart';
import 'package:enxolist/presentation/pages/categories/categories_screen.dart';
import 'package:enxolist/presentation/pages/finances/finance_screen.dart';
import 'package:enxolist/presentation/pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class PageNavigatorScreen extends StatefulWidget {
  PageNavigatorScreen({super.key});

  @override
  State<PageNavigatorScreen> createState() => _PageNavigatorScreenState();
}

class _PageNavigatorScreenState extends State<PageNavigatorScreen> {
  final controller = getIt<PageNavigatorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(ThemeConstants.halfPadding),
        child: GNav(
          rippleColor: Colors.white,
          hoverColor: Theme.of(context).colorScheme.primary.withAlpha(100),
          haptic: true,
          tabBorderRadius: 25,
          tabActiveBorder:
              Border.all(color: Theme.of(context).colorScheme.primary),
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 350),
          gap: ThemeConstants.halfPadding,
          color: Theme.of(context).colorScheme.primary,
          iconSize: 24,
          activeColor: Colors.white,
          tabBackgroundColor: Theme.of(context).colorScheme.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeConstants.padding,
            vertical: ThemeConstants.halfPadding,
          ),
          onTabChange: (index) => controller.changeToPage(index),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.wallet,
              text: 'Finanças',
            ),
            GButton(
              icon: Icons.person,
              text: 'Person ',
            ),
          ],
        ),
      ),
      body: Observer(builder: (context) {
        return _selectedPage(controller.selectedPage);
      }),
    );
  }

  Widget _selectedPage(int i) {
    Map<int, Widget> pagesMap = {
      0: const CategoriesScreen(),
      1: const FinanceScreen(),
      2: const ProfileScreen(),
    };

    if (i <= pagesMap.length) {
      return pagesMap[i]!;
    }
    return pagesMap[0]!;
  }
}
