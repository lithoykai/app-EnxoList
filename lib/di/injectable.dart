import 'dart:io';

import 'package:enxolist/data/models/auth/response/user_DTO.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void setup() {}

Future<void> init() async {
  Hive.registerAdapter(UserResponseAdapter());
  Hive.registerAdapter(UserDTOAdapter());
  getIt.registerLazySingleton<HiveInterface>(() => Hive);
  // getIt.registerFactory<HttpClientApp>(() => HttpClientApp());
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  var hiveData = Directory('${directory.path}/db');
  await Hive.initFlutter(hiveData.path);

  $initGetIt(getIt);
}
