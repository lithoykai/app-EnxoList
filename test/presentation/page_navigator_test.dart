import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/presentation/page-navigator/controller/page_navigator_controller.dart';
import 'package:enxolist/presentation/page-navigator/page_navigator.dart';
import 'package:enxolist/presentation/pages/categories/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  late MaterialApp widgetApp;

  setUp(() {
    if (!getIt.isRegistered<PageNavigatorController>()) {
      getIt.registerSingleton<PageNavigatorController>(
          PageNavigatorController());
    }

    widgetApp = MaterialApp(
      home: PageNavigatorScreen(),
    );
  });

  testWidgets('When click on home then CategoriesScreen is showing',
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(widgetApp);

    final buttons = find.byWidgetPredicate((widget) => widget is GButton);

    expect(buttons, findsNWidgets(3));

    await widgetTester.tap(buttons.first);
    await widgetTester.pumpAndSettle();
    final tab = find.byWidgetPredicate((widget) => widget is CategoriesScreen);
    expect(tab, findsOneWidget);
  });
}
