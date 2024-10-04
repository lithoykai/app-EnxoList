// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i23;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_source/clients/http_client.dart' as _i15;
import '../data/data_source/clients/http_client_dev.dart' as _i16;
import '../data/data_source/clients/remote_config/remote_config.dart' as _i5;
import '../data/data_source/clients/third_module.dart' as _i33;
import '../data/data_source/cost_value/cost_values_remote_datasource.dart'
    as _i17;
import '../data/data_source/cost_value/cost_values_remote_datasource_impl.dart'
    as _i18;
import '../data/data_source/notification/notification_remote_datasource.dart'
    as _i20;
import '../data/data_source/notification/notification_remote_datasource_impl.dart'
    as _i21;
import '../data/data_source/product/product_remote_datasource.dart' as _i11;
import '../data/repositories/notification/notification_repository_impl.dart'
    as _i27;
import '../data/repositories/product/cost_values_repository_impl.dart' as _i25;
import '../data/repositories/product/product_repository_impl.dart' as _i10;
import '../data/services/auth/auth_service.dart' as _i22;
import '../domain/repositories/cost_values_repository.dart' as _i24;
import '../domain/repositories/notification_repository.dart' as _i26;
import '../domain/repositories/product_repository.dart' as _i9;
import '../domain/use-cases/finances/get_percentage.dart' as _i29;
import '../domain/use-cases/notification/get_notification_count_usecase.dart'
    as _i28;
import '../domain/use-cases/notification/get_notification_usecase.dart' as _i30;
import '../domain/use-cases/product/create_product.dart' as _i12;
import '../domain/use-cases/product/delete_product.dart' as _i13;
import '../domain/use-cases/product/get_products.dart' as _i14;
import '../infra/theme/controller/theme_controller.dart' as _i6;
import '../infra/utils/store.dart' as _i4;
import '../presentation/page-navigator/controller/page_navigator_controller.dart'
    as _i7;
import '../presentation/pages/categories/controller/categories_controller.dart'
    as _i19;
import '../presentation/pages/categories/controller/cost_controller.dart'
    as _i31;
import '../presentation/pages/notification/controller/notification_controller.dart'
    as _i32;
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
  gh.factory<_i9.IProductRepository>(() =>
      _i10.ProductRepositoryImpl(dataSource: gh<_i11.IProductDataSource>()));
  gh.factory<_i12.CreateProductUseCase>(() =>
      _i12.CreateProductUseCase(repository: gh<_i9.IProductRepository>()));
  gh.factory<_i13.DeleteProductUseCase>(() =>
      _i13.DeleteProductUseCase(repository: gh<_i9.IProductRepository>()));
  gh.factory<_i14.GetProductsUseCase>(
      () => _i14.GetProductsUseCase(repository: gh<_i9.IProductRepository>()));
  gh.factory<_i15.HttpClientApp>(() => _i16.HttpClientAppDev(
        dio: gh<_i3.Dio>(),
        remoteConfig: gh<_i5.RemoteConfig>(),
      ));
  gh.factory<_i17.CostValuesDataSource>(() =>
      _i18.CostValuesDataSourceImpl(httpClient: gh<_i15.HttpClientApp>()));
  gh.singleton<_i19.CategoriesController>(() => _i19.CategoriesController(
        getProductsUseCase: gh<_i14.GetProductsUseCase>(),
        deleteProductUseCase: gh<_i13.DeleteProductUseCase>(),
        createProductUseCase: gh<_i12.CreateProductUseCase>(),
      ));
  gh.factory<_i20.INotificationRemoteDataSource>(() =>
      _i21.NotificationRemoteDatasourceImpl(http: gh<_i15.HttpClientApp>()));
  gh.lazySingleton<_i22.AuthService>(() => _i22.AuthService(
        http: gh<_i15.HttpClientApp>(),
        hive: gh<_i23.HiveInterface>(),
      ));
  gh.factory<_i24.CostValuesRepository>(() => _i25.CostValuesRepositoryImpl(
      dataSource: gh<_i17.CostValuesDataSource>()));
  gh.factory<_i26.NotificationRepository>(() => _i27.NotificationRepositoryImpl(
      datasource: gh<_i20.INotificationRemoteDataSource>()));
  gh.factory<_i28.GetNotificationCountUsecase>(() =>
      _i28.GetNotificationCountUsecase(gh<_i26.NotificationRepository>()));
  gh.factory<_i29.GetPercetangeUseCase>(() =>
      _i29.GetPercetangeUseCase(repository: gh<_i24.CostValuesRepository>()));
  gh.factory<_i30.GetNotificationUsecase>(() => _i30.GetNotificationUsecase(
      repository: gh<_i26.NotificationRepository>()));
  gh.singleton<_i31.CostController>(() => _i31.CostController(
      getPercetangeUseCase: gh<_i29.GetPercetangeUseCase>()));
  gh.lazySingleton<_i32.NotificationController>(
      () => _i32.NotificationController(
            getNotificationUsecase: gh<_i30.GetNotificationUsecase>(),
            getNotificationCountUseCase: gh<_i28.GetNotificationCountUsecase>(),
          ));
  return getIt;
}

class _$RegisterModule extends _i33.RegisterModule {}
