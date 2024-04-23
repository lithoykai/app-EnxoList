import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/infra/utils/approuter.dart';
import 'package:enxolist/infra/utils/store.dart';
import 'package:enxolist/presentation/pages/onboarding/widget/editable_info_widget.dart';
import 'package:enxolist/presentation/pages/onboarding/widget/list_info_widget.dart';
import 'package:enxolist/presentation/pages/onboarding/widget/page_indicator.dart';
import 'package:enxolist/presentation/pages/onboarding/widget/welcome.dart';
import 'package:flutter/material.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  int pageIndicator = 0;

  void changePage() async {
    if (pageIndicator == 2) {
      await StoreData.saveBool('onboardPage', true).then((value) =>
          Navigator.of(context).pushReplacementNamed(AppRouter.AUTH_OR_HOME));
      setState(() {
        pageIndicator = 0;
      });
    } else {
      setState(() {
        pageIndicator++;
      });
    }
  }

  void seenPage() async {
    final seePage = await StoreData.getBool('onboardPage');
    if (seePage == null) {
      await StoreData.saveBool('onboardPage', true);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 85,
              child: _pages(pageIndicator),
            ),
            Padding(
              padding: const EdgeInsets.all(ThemeConstants.doublePadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      await StoreData.saveBool('onboardPage', true).then(
                          (value) => Navigator.of(context)
                              .pushReplacementNamed(AppRouter.AUTH_OR_HOME));
                    },
                    child: Text(
                      'Pular',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  PageIndicator(currentValue: pageIndicator),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: changePage,
                    child: pageIndicator != 2
                        ? Icon(Icons.arrow_forward_ios,
                            color: Theme.of(context).colorScheme.outline)
                        : const Text(
                            'Iniciar',
                            style: TextStyle(color: Colors.white),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pages(int index) {
    Map<int, Widget> pagesMap = {
      0: const WelcomeScreen(),
      1: const ListInfoWidget(),
      2: const EditableInfoWidget(),
    };

    if (index <= pagesMap.length) {
      return pagesMap[index]!;
    }
    return pagesMap[0]!;
  }
}
