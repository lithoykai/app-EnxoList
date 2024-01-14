import 'package:enxolist/di/injectable.dart' as di;
import 'package:enxolist/presentation/app/app_widget.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const AppWidget());
}
