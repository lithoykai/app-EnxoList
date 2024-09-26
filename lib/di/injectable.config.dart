// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i22;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_source/clients/http_client.dart' as _i11;
import '../data/data_source/clients/http_client_dev.dart' as _i12;
import '../data/data_source/clients/remote_config/remote_config.dart' as _i5;
import '../data/data_source/clients/third_module.dart' as _i36;
import '../data/data_source/cost_value/cost_values_remote_datasource.dart'
    as _i17;
import '../data/data_source/cost_value/cost_values_remote_datasource_impl.dart'
    as _i18;
import '../data/data_source/notification/notification_remote_datasource.dart'
    as _i19;
import '../data/data_source/notification/notification_remote_datasource_impl.dart'
    as _i20;
import '../data/data_source/product/product_remote_datasource.dart' as _i13;
import '../data/data_source/product/product_remote_datasource_impl.dart'
    as _i14;
import '../data/repositories/notification/notification_repository_impl.dart'
    as _i30;
import '../data/repositories/product/cost_values_repository_impl.dart' as _i27;
import '../data/repositories/product/product_repository_impl.dart' as _i16;
import '../data/services/auth/auth_service.dart' as _i21;
import '../data/services/firebase/firebase_service.dart' as _i9;
import '../data/services/firebase/firebase_service_impl.dart' as _i10;
import '../domain/repositories/cost_values_repository.dart' as _i26;
import '../domain/repositories/notification_repository.dart' as _i29;
import '../domain/repositories/product_repository.dart' as _i15;
import '../domain/use-cases/finances/get_percentage.dart' as _i32;
import '../domain/use-cases/notification/get_notification_count_usecase.dart'
    as _i31;
import '../domain/use-cases/notification/get_notification_usecase.dart' as _i33;
import '../domain/use-cases/product/create_product.dart' as _i23;
import '../domain/use-cases/product/delete_product.dart' as _i24;
import '../domain/use-cases/product/get_products.dart' as _i25;
import '../infra/theme/controller/theme_controller.dart' as _i6;
import '../infra/utils/store.dart' as _i4;
import '../presentation/page-navigator/controller/page_navigator_controller.dart'
    as _i7;
import '../presentation/pages/categories/controller/categories_controller.dart'
    as _i28;
import '../presentation/pages/categories/controller/cost_controller.dart'
    as _i34;
import '../presentation/pages/notification/controller/notification_controller.dart'
    as _i35;
import '../presentation/pages/profile/controller/profile_controller.dart'
    as _i8;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i3.Dio>(() => registerModule.dio());
  gh.factory<_i4.StoreHive>(() => _i4.StoreHive());
  gh.factory<_i5.RemoteConfig>(() => _i5.RemoteConfig());
  gh.singleton<_i6.ThemeController>(() => _i6.ThemeController());
  gh.singleton<_i7.PageNavigatorController>(
      () => _i7.PageNavigatorController());
  gh.lazySingleton<_i8.ProfileController>(() => _i8.ProfileController());
  gh.factory<_i9.FirebaseService>(() => _i10.FirebaseServiceImpl());
  gh.factory<_i11.HttpClientApp>(() => _i12.HttpClientAppDev(
        dio: gh<_i3.Dio>(),
        remoteConfig: gh<_i5.RemoteConfig>(),
      ));
  gh.factory<_i13.IProductDataSource>(() => _i14.ProductDataSourceImpl(
        http: gh<_i11.HttpClientApp>(),
        firebaseService: gh<_i9.FirebaseService>(),
      ));
  gh.factory<_i15.IProductRepository>(() =>
      _i16.ProductRepositoryImpl(dataSouce: gh<_i13.IProductDataSource>()));
  gh.factory<_i17.CostValuesDataSource>(() =>
      _i18.CostValuesDataSourceImpl(httpClient: gh<_i11.HttpClientApp>()));
  gh.factory<_i19.INotificationRemoteDataSource>(() =>
      _i20.NotificationRemoteDatasourceImpl(http: gh<_i11.HttpClientApp>()));
  gh.lazySingleton<_i21.AuthService>(() => _i21.AuthService(
        http: gh<_i11.HttpClientApp>(),
        hive: gh<_i22.HiveInterface>(),
      ));
  gh.factory<_i23.CreateProductUseCase>(() =>
      _i23.CreateProductUseCase(repository: gh<_i15.IProductRepository>()));
  gh.factory<_i24.DeleteProductUseCase>(() =>
      _i24.DeleteProductUseCase(repository: gh<_i15.IProductRepository>()));
  gh.factory<_i25.GetProductsUseCase>(
      () => _i25.GetProductsUseCase(repository: gh<_i15.IProductRepository>()));
  gh.factory<_i26.CostValuesRepository>(() => _i27.CostValuesRepositoryImpl(
      dataSource: gh<_i17.CostValuesDataSource>()));
  gh.singleton<_i28.CategoriesController>(() => _i28.CategoriesController(
        getProductsUseCase: gh<_i25.GetProductsUseCase>(),
        deleteProductUseCase: gh<_i24.DeleteProductUseCase>(),
        createProductUseCase: gh<_i23.CreateProductUseCase>(),
      ));
  gh.factory<_i29.NotificationRepository>(() => _i30.NotificationRepositoryImpl(
      datasource: gh<_i19.INotificationRemoteDataSource>()));
  gh.factory<_i31.GetNotificationCountUsecase>(() =>
      _i31.GetNotificationCountUsecase(gh<_i29.NotificationRepository>()));
  gh.factory<_i32.GetPercetangeUseCase>(() =>
      _i32.GetPercetangeUseCase(repository: gh<_i26.CostValuesRepository>()));
  gh.factory<_i33.GetNotificationUsecase>(() => _i33.GetNotificationUsecase(
      repository: gh<_i29.NotificationRepository>()));
  gh.singleton<_i34.CostController>(() => _i34.CostController(
      getPercetangeUseCase: gh<_i32.GetPercetangeUseCase>()));
  gh.lazySingleton<_i35.NotificationController>(
      () => _i35.NotificationController(
            getNotificationUsecase: gh<_i33.GetNotificationUsecase>(),
            getNotificationCountUseCase: gh<_i31.GetNotificationCountUsecase>(),
          ));
  return getIt;
}

class _$RegisterModule extends _i36.RegisterModule {}
