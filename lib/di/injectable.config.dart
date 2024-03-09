// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i16;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_source/clients/http_clients.dart' as _i6;
import '../data/data_source/clients/third_module.dart' as _i21;
import '../data/data_source/product_remote_datasource.dart' as _i7;
import '../data/data_source/product_remote_datasource_impl.dart' as _i8;
import '../data/repositories/product/product_repository_impl.dart' as _i10;
import '../data/services/auth/auth_service.dart' as _i15;
import '../data/services/firebase/firebase_service.dart' as _i4;
import '../data/services/firebase/firebase_service_impl.dart' as _i5;
import '../domain/repositories/product_repository.dart' as _i9;
import '../domain/use-cases/product/create_product.dart' as _i17;
import '../domain/use-cases/product/delete_product.dart' as _i18;
import '../domain/use-cases/product/get_products.dart' as _i19;
import '../infra/theme/controller/theme_controller.dart' as _i14;
import '../infra/utils/store.dart' as _i13;
import '../presentation/page-navigator/controller/page_navigator_controller.dart'
    as _i11;
import '../presentation/pages/categories/controller/categories_controller.dart'
    as _i20;
import '../presentation/pages/profile/controller/profile_controller.dart'
    as _i12;

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
  gh.factory<_i6.HttpClientApp>(() => _i6.HttpClientApp(dio: gh<_i3.Dio>()));
  gh.factory<_i7.IProductDataSource>(() => _i8.ProductDataSourceImpl(
        http: gh<_i6.HttpClientApp>(),
        firebaseService: gh<_i4.FirebaseService>(),
      ));
  gh.factory<_i9.IProductRepository>(() =>
      _i10.ProductRepositoryImpl(dataSouce: gh<_i7.IProductDataSource>()));
  gh.singleton<_i11.PageNavigatorController>(_i11.PageNavigatorController());
  gh.lazySingleton<_i12.ProfileController>(() => _i12.ProfileController());
  gh.factory<_i13.StoreHive>(() => _i13.StoreHive());
  gh.singleton<_i14.ThemeController>(_i14.ThemeController());
  gh.lazySingleton<_i15.AuthService>(() => _i15.AuthService(
        http: gh<_i6.HttpClientApp>(),
        hive: gh<_i16.HiveInterface>(),
      ));
  gh.factory<_i17.CreateProductUseCase>(() =>
      _i17.CreateProductUseCase(repository: gh<_i9.IProductRepository>()));
  gh.factory<_i18.DeleteProductUseCase>(() =>
      _i18.DeleteProductUseCase(repository: gh<_i9.IProductRepository>()));
  gh.factory<_i19.GetProductsUseCase>(
      () => _i19.GetProductsUseCase(repository: gh<_i9.IProductRepository>()));
  gh.singleton<_i20.CategoriesController>(_i20.CategoriesController(
    getProductsUseCase: gh<_i19.GetProductsUseCase>(),
    deleteProductUseCase: gh<_i18.DeleteProductUseCase>(),
    createProductUseCase: gh<_i17.CreateProductUseCase>(),
  ));
  return getIt;
}

class _$RegisterModule extends _i21.RegisterModule {}
