import 'dart:io';

import 'package:enxolist/data/data_source/clients/http_client.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource_offline.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource_online.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource_proxy.dart';
import 'package:enxolist/data/models/auth/response/user_DTO.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/data/services/firebase/firebase_service.dart';
import 'package:enxolist/data/services/firebase/firebase_service_impl.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/infra/utils/store.dart';
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
  Hive.registerAdapter(ProductEntityAdapter());
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  var hiveData = Directory('${directory.path}/db');
  await Hive.initFlutter(hiveData.path);
  bool isOffline = await StoreData.getBool('offlineMode') ?? false;
  getIt.registerFactory<HiveInterface>(() => Hive);

  getIt.registerFactory<ProductRemoteDataSourceOnline>(
      () => ProductRemoteDataSourceOnline(
            http: getIt<HttpClientApp>(),
            firebaseService: getIt<FirebaseService>(),
          ));
  getIt.allowReassignment = true;

  getIt.registerFactory<ProductRemoteDataSourceOffline>(
      () => ProductRemoteDataSourceOffline(
            hive: getIt<HiveInterface>(),
          ));
  getIt.registerFactory<FirebaseService>(() => FirebaseServiceImpl());
  getIt.registerLazySingleton<ProductDataSourceProxy>(
    () => ProductDataSourceProxy(getIt<ProductRemoteDataSourceOffline>()),
  );
  getIt.registerLazySingleton<IProductDataSource>(() => IProductDataSource());
  $initGetIt(getIt);

  // getIt.registerLazySingleton<ProductRemoteDataSourceOffline>(
  //     () => ProductRemoteDataSourceOffline(hive: getIt<HiveInterface>()));
}
