import 'package:dio/dio.dart';
import 'package:enxolist/data/data_source/clients/http_clients.dart';
import 'package:enxolist/data/services/auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void setup() {
  getIt.registerLazySingleton<AuthService>(
      () => AuthService(http: HttpClientApp(dio: Dio())));
}

Future<void> init() async {
  await Hive.initFlutter();
  $initGetIt(getIt);
}
