// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i17;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_source/clients/http_clients.dart' as _i11;
import '../data/data_source/clients/third_module.dart' as _i22;
import '../data/data_source/product_remote_datasource.dart' as _i12;
import '../data/data_source/product_remote_datasource_impl.dart' as _i13;
import '../data/data_source/remote_config/remote_config.dart' as _i8;
import '../data/repositories/product/product_repository_impl.dart' as _i15;
import '../data/services/auth/auth_service.dart' as _i16;
import '../data/services/firebase/firebase_service.dart' as _i4;
import '../data/services/firebase/firebase_service_impl.dart' as _i5;
import '../domain/repositories/product_repository.dart' as _i14;
import '../domain/use-cases/product/create_product.dart' as _i18;
import '../domain/use-cases/product/delete_product.dart' as _i19;
import '../domain/use-cases/product/get_products.dart' as _i20;
import '../infra/theme/controller/theme_controller.dart' as _i10;
import '../infra/utils/store.dart' as _i9;
import '../presentation/page-navigator/controller/page_navigator_controller.dart'
    as _i6;
import '../presentation/pages/categories/controller/categories_controller.dart'
    as _i21;
import '../presentation/pages/profile/controller/profile_controller.dart'
    as _i7;

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
  gh.factory<_i4.FirebaseService>(() => _i5.FirebaseServiceImpl());
  gh.singleton<_i6.PageNavigatorController>(_i6.PageNavigatorController());
  gh.lazySingleton<_i7.ProfileController>(() => _i7.ProfileController());
  gh.factory<_i8.RemoteConfig>(() => _i8.RemoteConfig());
  gh.factory<_i9.StoreHive>(() => _i9.StoreHive());
  gh.singleton<_i10.ThemeController>(_i10.ThemeController());
  gh.factory<_i11.HttpClientApp>(() => _i11.HttpClientApp(
        dio: gh<_i3.Dio>(),
        remoteConfig: gh<_i8.RemoteConfig>(),
      ));
  gh.factory<_i12.IProductDataSource>(() => _i13.ProductDataSourceImpl(
        http: gh<_i11.HttpClientApp>(),
        firebaseService: gh<_i4.FirebaseService>(),
      ));
  gh.factory<_i14.IProductRepository>(() =>
      _i15.ProductRepositoryImpl(dataSouce: gh<_i12.IProductDataSource>()));
  gh.lazySingleton<_i16.AuthService>(() => _i16.AuthService(
        http: gh<_i11.HttpClientApp>(),
        hive: gh<_i17.HiveInterface>(),
      ));
  gh.factory<_i18.CreateProductUseCase>(() =>
      _i18.CreateProductUseCase(repository: gh<_i14.IProductRepository>()));
  gh.factory<_i19.DeleteProductUseCase>(() =>
      _i19.DeleteProductUseCase(repository: gh<_i14.IProductRepository>()));
  gh.factory<_i20.GetProductsUseCase>(
      () => _i20.GetProductsUseCase(repository: gh<_i14.IProductRepository>()));
  gh.singleton<_i21.CategoriesController>(_i21.CategoriesController(
    getProductsUseCase: gh<_i20.GetProductsUseCase>(),
    deleteProductUseCase: gh<_i19.DeleteProductUseCase>(),
    createProductUseCase: gh<_i18.CreateProductUseCase>(),
  ));
  return getIt;
}

class _$RegisterModule extends _i22.RegisterModule {}
