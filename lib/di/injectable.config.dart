// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/data_source/clients/http_clients.dart' as _i4;
import '../data/data_source/clients/third_module.dart' as _i10;
import '../data/data_source/product_remote_datasource.dart' as _i5;
import '../data/data_source/product_remote_datasource_impl.dart' as _i6;
import '../data/repositories/product/product_repository_impl.dart' as _i8;
import '../domain/use-cases/product/get_products.dart' as _i9;
import '../repositories/product_repository.dart' as _i7;

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
  gh.factory<_i9.GetProductsUseCase>(
      () => _i9.GetProductsUseCase(repository: gh<_i7.IProductRepository>()));
  return getIt;
}

class _$RegisterModule extends _i10.RegisterModule {}
