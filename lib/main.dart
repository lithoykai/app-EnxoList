import 'dart:async';

import 'package:enxolist/di/injectable.dart' as di;
import 'package:enxolist/infra/failure/failure.dart';
import 'package:enxolist/presentation/app/app_config.dart';
import 'package:enxolist/presentation/app/app_widget.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final StreamController<Failure?> streamError =
      StreamController<Failure?>.broadcast();

  AppConfig(
      streamError: streamError,
      onDispose: () {
        streamError.close();
      });

  await di.init();

  runApp(const AppWidget());
}
