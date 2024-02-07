// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i13;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_source/clients/http_clients.dart' as _i4;
import '../data/data_source/clients/third_module.dart' as _i16;
import '../data/data_source/product_remote_datasource.dart' as _i5;
import '../data/data_source/product_remote_datasource_impl.dart' as _i6;
import '../data/repositories/product/product_repository_impl.dart' as _i8;
import '../data/services/auth/auth_service.dart' as _i12;
import '../domain/repositories/product_repository.dart' as _i7;
import '../domain/use-cases/product/get_products.dart' as _i14;
import '../infra/utils/store.dart' as _i11;
import '../presentation/page-navigator/controller/page_navigator_controller.dart'
    as _i9;
import '../presentation/pages/categories/controller/categories_controller.dart'
    as _i15;
import '../presentation/pages/profile/controller/profile_controller.dart'
    as _i10;

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
  gh.factory<_i4.HttpClientApp>(() => _i4.HttpClientApp(dio: gh<_i3.Dio>()));
  gh.factory<_i5.IProductDataSource>(
      () => _i6.ProductDataSourceImpl(http: gh<_i4.HttpClientApp>()));
  gh.factory<_i7.IProductRepository>(
      () => _i8.ProductRepositoryImpl(dataSouce: gh<_i5.IProductDataSource>()));
  gh.singleton<_i9.PageNavigatorController>(_i9.PageNavigatorController());
  gh.lazySingleton<_i10.ProfileController>(() => _i10.ProfileController());
  gh.factory<_i11.StoreHive>(() => _i11.StoreHive());
  gh.lazySingleton<_i12.AuthService>(() => _i12.AuthService(
        http: gh<_i4.HttpClientApp>(),
        hive: gh<_i13.HiveInterface>(),
      ));
  gh.factory<_i14.GetProductsUseCase>(
      () => _i14.GetProductsUseCase(repository: gh<_i7.IProductRepository>()));
  gh.singleton<_i15.CategoriesController>(_i15.CategoriesController(
      getProductsUseCase: gh<_i14.GetProductsUseCase>()));
  return getIt;
}

class _$RegisterModule extends _i16.RegisterModule {}
