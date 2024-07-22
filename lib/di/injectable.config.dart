// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i18;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_source/clients/http_client.dart' as _i11;
import '../data/data_source/clients/http_client_prod.dart' as _i12;
import '../data/data_source/clients/third_module.dart' as _i29;
import '../data/data_source/cost_values_remote_datasource.dart' as _i13;
import '../data/data_source/cost_values_remote_datasource_impl.dart' as _i14;
import '../data/data_source/product_remote_datasource.dart' as _i15;
import '../data/data_source/product_remote_datasource_impl.dart' as _i16;
import '../data/data_source/remote_config/remote_config.dart' as _i4;
import '../data/repositories/product/cost_values_repository_impl.dart' as _i20;
import '../data/repositories/product/product_repository_impl.dart' as _i24;
import '../data/services/auth/auth_service.dart' as _i17;
import '../data/services/firebase/firebase_service.dart' as _i9;
import '../data/services/firebase/firebase_service_impl.dart' as _i10;
import '../domain/repositories/cost_values_repository.dart' as _i19;
import '../domain/repositories/product_repository.dart' as _i23;
import '../domain/use-cases/finances/get_percentage.dart' as _i21;
import '../domain/use-cases/product/create_product.dart' as _i25;
import '../domain/use-cases/product/delete_product.dart' as _i26;
import '../domain/use-cases/product/get_products.dart' as _i27;
import '../infra/theme/controller/theme_controller.dart' as _i6;
import '../infra/utils/store.dart' as _i5;
import '../presentation/page-navigator/controller/page_navigator_controller.dart'
    as _i7;
import '../presentation/pages/categories/controller/categories_controller.dart'
    as _i28;
import '../presentation/pages/categories/controller/cost_controller.dart'
    as _i22;
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
  gh.factory<_i4.RemoteConfig>(() => _i4.RemoteConfig());
  gh.factory<_i5.StoreHive>(() => _i5.StoreHive());
  gh.singleton<_i6.ThemeController>(() => _i6.ThemeController());
  gh.singleton<_i7.PageNavigatorController>(
      () => _i7.PageNavigatorController());
  gh.lazySingleton<_i8.ProfileController>(() => _i8.ProfileController());
  gh.factory<_i9.FirebaseService>(() => _i10.FirebaseServiceImpl());
  gh.factory<_i11.HttpClientApp>(() => _i12.HttpClientAppProd(
        dio: gh<_i3.Dio>(),
        remoteConfig: gh<_i4.RemoteConfig>(),
      ));
  gh.factory<_i13.CostValuesDataSource>(() =>
      _i14.CostValuesDataSourceImpl(httpClient: gh<_i11.HttpClientApp>()));
  gh.factory<_i15.IProductDataSource>(() => _i16.ProductDataSourceImpl(
        http: gh<_i11.HttpClientApp>(),
        firebaseService: gh<_i9.FirebaseService>(),
      ));
  gh.lazySingleton<_i17.AuthService>(() => _i17.AuthService(
        http: gh<_i11.HttpClientApp>(),
        hive: gh<_i18.HiveInterface>(),
      ));
  gh.factory<_i19.CostValuesRepository>(() => _i20.CostValuesRepositoryImpl(
      dataSource: gh<_i13.CostValuesDataSource>()));
  gh.factory<_i21.GetPercetangeUseCase>(() =>
      _i21.GetPercetangeUseCase(repository: gh<_i19.CostValuesRepository>()));
  gh.singleton<_i22.CostController>(() => _i22.CostController(
      getPercetangeUseCase: gh<_i21.GetPercetangeUseCase>()));
  gh.factory<_i23.IProductRepository>(() =>
      _i24.ProductRepositoryImpl(dataSouce: gh<_i15.IProductDataSource>()));
  gh.factory<_i25.CreateProductUseCase>(() =>
      _i25.CreateProductUseCase(repository: gh<_i23.IProductRepository>()));
  gh.factory<_i26.DeleteProductUseCase>(() =>
      _i26.DeleteProductUseCase(repository: gh<_i23.IProductRepository>()));
  gh.factory<_i27.GetProductsUseCase>(
      () => _i27.GetProductsUseCase(repository: gh<_i23.IProductRepository>()));
  gh.singleton<_i28.CategoriesController>(() => _i28.CategoriesController(
        getProductsUseCase: gh<_i27.GetProductsUseCase>(),
        deleteProductUseCase: gh<_i26.DeleteProductUseCase>(),
        createProductUseCase: gh<_i25.CreateProductUseCase>(),
      ));
  return getIt;
}

class _$RegisterModule extends _i29.RegisterModule {}
