import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/presentation/page-navigator/categories/categories.dart';
import 'package:enxolist/presentation/page-navigator/controller/page_navigator_controller.dart';
import 'package:enxolist/presentation/page-navigator/finances/finance.dart';
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
    return Observer(builder: (context) {
      return Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(ThemeConstants.halfPadding),
          child: GNav(
            rippleColor: Theme.of(context).colorScheme.background,
            hoverColor: Theme.of(context).colorScheme.primary.withAlpha(100),
            haptic: true,
            tabBorderRadius: 25,
            tabActiveBorder:
                Border.all(color: Theme.of(context).colorScheme.primary),
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 350),
            gap: ThemeConstants.halfPadding,
            // color: ,
            iconSize: 24,
            activeColor: Theme.of(context).colorScheme.background,
            tabBackgroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeConstants.padding,
              vertical: ThemeConstants.halfPadding,
            ),
            onTabChange: (index) => controller.changeToPage(index),
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                icon: Icons.account_balance_wallet_outlined,
                text: 'Finanças',
              ),
              GButton(
                icon: Icons.person_outline,
                text: 'Person ',
              ),
            ],
          ),
        ),
        body: _selectedPage(controller.selectedPage),
      );
    });
  }

  Widget _selectedPage(int i) {
    Map<int, Widget> pagesMap = {
      0: const CategoriesScreen(),
      1: const FinanceScreen(),
      2: SafeArea(
        child: Container(
          color: Colors.amber,
          child: Text('Person'),
        ),
      ),
    };

    if (i <= pagesMap.length) {
      return pagesMap[i]!;
    }
    return pagesMap[0]!;
  }
}
