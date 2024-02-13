// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i15;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_source/clients/http_clients.dart' as _i6;
import '../data/data_source/clients/third_module.dart' as _i20;
import '../data/data_source/product_remote_datasource.dart' as _i7;
import '../data/data_source/product_remote_datasource_impl.dart' as _i8;
import '../data/repositories/product/product_repository_impl.dart' as _i10;
import '../data/services/auth/auth_service.dart' as _i14;
import '../data/services/firebase/firebase_service.dart' as _i4;
import '../data/services/firebase/firebase_service_impl.dart' as _i5;
import '../domain/repositories/product_repository.dart' as _i9;
import '../domain/use-cases/product/create_product.dart' as _i16;
import '../domain/use-cases/product/delete_product.dart' as _i17;
import '../domain/use-cases/product/get_products.dart' as _i18;
import '../infra/utils/store.dart' as _i13;
import '../presentation/page-navigator/controller/page_navigator_controller.dart'
    as _i11;
import '../presentation/pages/categories/controller/categories_controller.dart'
    as _i19;
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
  gh.lazySingleton<_i14.AuthService>(() => _i14.AuthService(
        http: gh<_i6.HttpClientApp>(),
        hive: gh<_i15.HiveInterface>(),
      ));
  gh.factory<_i16.CreateProductUseCase>(() =>
      _i16.CreateProductUseCase(repository: gh<_i9.IProductRepository>()));
  gh.factory<_i17.DeleteProductUseCase>(() =>
      _i17.DeleteProductUseCase(repository: gh<_i9.IProductRepository>()));
  gh.factory<_i18.GetProductsUseCase>(
      () => _i18.GetProductsUseCase(repository: gh<_i9.IProductRepository>()));
  gh.singleton<_i19.CategoriesController>(_i19.CategoriesController(
    getProductsUseCase: gh<_i18.GetProductsUseCase>(),
    deleteProductUseCase: gh<_i17.DeleteProductUseCase>(),
    createProductUseCase: gh<_i16.CreateProductUseCase>(),
  ));
  return getIt;
}

class _$RegisterModule extends _i20.RegisterModule {}
