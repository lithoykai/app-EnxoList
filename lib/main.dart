import 'package:enxolist/data/data_source/remote_config/remote_config.dart';
import 'package:enxolist/di/injectable.dart' as di;
import 'package:enxolist/firebase_options.dart';
import 'package:enxolist/presentation/app/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final StreamController<Failure?> streamError =
  //     StreamController<Failure?>.broadcast();

  // AppConfig(
  //     streamError: streamError,
  //     onDispose: () {
  //       streamError.close();
  //     });

  await di.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  RemoteConfig().initialize();
  runApp(const AppWidget());
}
