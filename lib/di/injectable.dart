import 'dart:io';

import 'package:enxolist/data/data_source/clients/http_client.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource_offline.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource_online.dart';
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

  getIt.registerFactory<HiveInterface>(() => Hive);

  getIt.registerFactory<ProductRemoteDataSourceOnline>(
      () => ProductRemoteDataSourceOnline(
            http: getIt<HttpClientApp>(),
            firebaseService: getIt<FirebaseService>(),
          ));

  getIt.registerFactory<ProductRemoteDataSourceOffline>(
      () => ProductRemoteDataSourceOffline(
            hive: getIt<HiveInterface>(),
          ));
  getIt.allowReassignment = true;
  getIt.registerFactory<FirebaseService>(() => FirebaseServiceImpl());
  getIt.registerLazySingleton<IProductDataSource>(
    () => StoreData.getBool('offlineMode') == true
        ? getIt<ProductRemoteDataSourceOffline>()
        : getIt<ProductRemoteDataSourceOnline>(),
  );
  $initGetIt(getIt);

  // getIt.registerLazySingleton<ProductRemoteDataSourceOffline>(
  //     () => ProductRemoteDataSourceOffline(hive: getIt<HiveInterface>()));
}
