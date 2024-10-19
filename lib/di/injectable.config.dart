// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive_flutter/hive_flutter.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_source/clients/http_client.dart' as _i16;
import '../data/data_source/clients/http_client_dev.dart' as _i17;
import '../data/data_source/clients/remote_config/remote_config.dart' as _i3;
import '../data/data_source/clients/third_module.dart' as _i43;
import '../data/data_source/cost_value/cost_values_remote_datasource.dart'
    as _i18;
import '../data/data_source/cost_value/cost_values_remote_datasource_impl.dart'
    as _i19;
import '../data/data_source/notification/notification_remote_datasource.dart'
    as _i21;
import '../data/data_source/notification/notification_remote_datasource_impl.dart'
    as _i22;
import '../data/data_source/product/product_remote_datasource.dart' as _i12;
import '../data/data_source/user/user_remote_datasource.dart' as _i23;
import '../data/data_source/user/user_remote_datasource_impl.dart' as _i24;
import '../data/repositories/notification/notification_repository_impl.dart'
    as _i30;
import '../data/repositories/product/cost_values_repository_impl.dart' as _i28;
import '../data/repositories/product/product_repository_impl.dart' as _i11;
import '../data/repositories/user/user_repository_impl.dart' as _i26;
import '../domain/repositories/cost_values_repository.dart' as _i27;
import '../domain/repositories/notification_repository.dart' as _i29;
import '../domain/repositories/product_repository.dart' as _i10;
import '../domain/repositories/user_repository.dart' as _i25;
import '../domain/use-cases/finances/get_percentage.dart' as _i38;
import '../domain/use-cases/notification/get_notification_count_usecase.dart'
    as _i37;
import '../domain/use-cases/notification/get_notification_usecase.dart' as _i39;
import '../domain/use-cases/product/create_product.dart' as _i13;
import '../domain/use-cases/product/delete_product.dart' as _i14;
import '../domain/use-cases/product/get_products.dart' as _i15;
import '../domain/use-cases/user/acceptCouple_usecase.dart' as _i32;
import '../domain/use-cases/user/authenticate_usecase.dart' as _i31;
import '../domain/use-cases/user/get_current_user_usecase.dart' as _i35;
import '../domain/use-cases/user/getCouple_usecase.dart' as _i33;
import '../domain/use-cases/user/logout_usecase.dart' as _i36;
import '../domain/use-cases/user/refuseCouple_usecase.dart' as _i34;
import '../infra/theme/controller/theme_controller.dart' as _i7;
import '../infra/utils/store.dart' as _i6;
import '../presentation/auth/controller/auth_controller.dart' as _i40;
import '../presentation/page-navigator/controller/page_navigator_controller.dart'
    as _i8;
import '../presentation/pages/categories/controller/categories_controller.dart'
    as _i20;
import '../presentation/pages/categories/controller/cost_controller.dart'
    as _i41;
import '../presentation/pages/notification/controller/notification_controller.dart'
    as _i42;
import '../presentation/pages/profile/controller/profile_controller.dart'
    as _i9;

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
  gh.factory<_i3.RemoteConfig>(() => _i3.RemoteConfig());
  gh.factory<_i4.Dio>(() => registerModule.dio());
  gh.factory<_i5.HiveInterface>(() => registerModule.hive());
  gh.factory<_i6.StoreHive>(() => _i6.StoreHive());
  gh.singleton<_i7.ThemeController>(() => _i7.ThemeController());
  gh.singleton<_i8.PageNavigatorController>(
      () => _i8.PageNavigatorController());
  gh.lazySingleton<_i9.ProfileController>(() => _i9.ProfileController());
  gh.factory<_i10.IProductRepository>(() =>
      _i11.ProductRepositoryImpl(dataSource: gh<_i12.IProductDataSource>()));
  gh.factory<_i13.CreateProductUseCase>(() =>
      _i13.CreateProductUseCase(repository: gh<_i10.IProductRepository>()));
  gh.factory<_i14.DeleteProductUseCase>(() =>
      _i14.DeleteProductUseCase(repository: gh<_i10.IProductRepository>()));
  gh.factory<_i15.GetProductsUseCase>(
      () => _i15.GetProductsUseCase(repository: gh<_i10.IProductRepository>()));
  gh.factory<_i16.HttpClientApp>(() => _i17.HttpClientAppDev(
        dio: gh<_i4.Dio>(),
        remoteConfig: gh<_i3.RemoteConfig>(),
      ));
  gh.factory<_i18.CostValuesDataSource>(() =>
      _i19.CostValuesDataSourceImpl(httpClient: gh<_i16.HttpClientApp>()));
  gh.singleton<_i20.CategoriesController>(() => _i20.CategoriesController(
        getProductsUseCase: gh<_i15.GetProductsUseCase>(),
        deleteProductUseCase: gh<_i14.DeleteProductUseCase>(),
        createProductUseCase: gh<_i13.CreateProductUseCase>(),
      ));
  gh.factory<_i21.INotificationRemoteDataSource>(() =>
      _i22.NotificationRemoteDatasourceImpl(http: gh<_i16.HttpClientApp>()));
  gh.factory<_i23.IUserRemoteDataSource>(() =>
      _i24.UserRemoteDatasourceImpl(httpClient: gh<_i16.HttpClientApp>()));
  gh.factory<_i25.IUserRepository>(() => _i26.UserRepositoryImpl(
        dataSource: gh<_i23.IUserRemoteDataSource>(),
        hive: gh<_i5.HiveInterface>(),
      ));
  gh.factory<_i27.CostValuesRepository>(() => _i28.CostValuesRepositoryImpl(
      dataSource: gh<_i18.CostValuesDataSource>()));
  gh.factory<_i29.NotificationRepository>(() => _i30.NotificationRepositoryImpl(
      datasource: gh<_i21.INotificationRemoteDataSource>()));
  gh.factory<_i31.AuthenticateUsecase>(
      () => _i31.AuthenticateUsecase(repository: gh<_i25.IUserRepository>()));
  gh.factory<_i32.AcceptCoupleUseCase>(
      () => _i32.AcceptCoupleUseCase(repository: gh<_i25.IUserRepository>()));
  gh.factory<_i33.GetCoupleUseCase>(
      () => _i33.GetCoupleUseCase(repository: gh<_i25.IUserRepository>()));
  gh.factory<_i34.RefuseCoupleUseCase>(
      () => _i34.RefuseCoupleUseCase(repository: gh<_i25.IUserRepository>()));
  gh.factory<_i35.GetCurrentUserUsecase>(
      () => _i35.GetCurrentUserUsecase(repository: gh<_i25.IUserRepository>()));
  gh.factory<_i36.LogoutUsecase>(
      () => _i36.LogoutUsecase(repository: gh<_i25.IUserRepository>()));
  gh.factory<_i37.GetNotificationCountUsecase>(() =>
      _i37.GetNotificationCountUsecase(gh<_i29.NotificationRepository>()));
  gh.factory<_i38.GetPercetangeUseCase>(() =>
      _i38.GetPercetangeUseCase(repository: gh<_i27.CostValuesRepository>()));
  gh.factory<_i39.GetNotificationUsecase>(() => _i39.GetNotificationUsecase(
      repository: gh<_i29.NotificationRepository>()));
  gh.singleton<_i40.AuthController>(() => _i40.AuthController(
        getCurrentUserUsecase: gh<_i35.GetCurrentUserUsecase>(),
        authenticateUsecase: gh<_i31.AuthenticateUsecase>(),
        acceptCoupleUseCase: gh<_i32.AcceptCoupleUseCase>(),
        getCoupleUseCase: gh<_i33.GetCoupleUseCase>(),
        refuseCoupleUseCase: gh<_i34.RefuseCoupleUseCase>(),
        logoutUsecase: gh<_i36.LogoutUsecase>(),
      ));
  gh.singleton<_i41.CostController>(() => _i41.CostController(
      getPercetangeUseCase: gh<_i38.GetPercetangeUseCase>()));
  gh.lazySingleton<_i42.NotificationController>(
      () => _i42.NotificationController(
            getNotificationUsecase: gh<_i39.GetNotificationUsecase>(),
            getNotificationCountUseCase: gh<_i37.GetNotificationCountUsecase>(),
          ));
  return getIt;
}

class _$RegisterModule extends _i43.RegisterModule {}
