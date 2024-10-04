import 'dart:io'; // If you need to use File

import 'package:enxolist/data/data_source/product/product_remote_datasource.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource_offline.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/product_fixture.dart';
import 'product_datasource_offline_test.mocks.dart';

@GenerateMocks([HiveInterface, Box<ProductEntity>])
void main() {
  late MockHiveInterface hive;
  late MockBox mockHiveBox;
  late IProductDataSource dataSource;

  setUp(() {
    hive = MockHiveInterface();
    mockHiveBox = MockBox();
    dataSource = ProductRemoteDataSourceOffline(hive: hive);
  });

  group('Should test DataSource Offline', () {
    test('should create product', () async {
      final _fakeProduct = fakeProductModel;
      final imageFile = File('path');
      final _fakeEntity = _fakeProduct.toEntity();
      _fakeEntity.image = imageFile.path;

      when(hive.openBox("CATEGORY: ${_fakeProduct.category}"))
          .thenAnswer((_) async => mockHiveBox);

      when(mockHiveBox.add(any)).thenAnswer((_) async => 0);

      final result =
          await dataSource.createProduct(_fakeProduct, imageFile: imageFile);

      expect(result, isA<ProductEntity>());
      expect(mockHiveBox.add(_fakeEntity), completes);
      verify(mockHiveBox.add(_fakeEntity));
      verify(hive.openBox("CATEGORY: ${_fakeProduct.category}"));
    });

    test('Should get products by category', () async {
      ProductEntity _fakeProduct = fakeProduct;
      final _fakeProductList = [_fakeProduct];
      final _fakeBox = MockBox<ProductEntity>();

      when(hive.box('CATEGORY: ${_fakeProduct.category}')).thenReturn(_fakeBox);
      when(_fakeBox.values).thenReturn(_fakeProductList);

      final result =
          await dataSource.getProductsByCategory(_fakeProduct.category);

      expect(result, isA<ProductResponse>());
      verify(hive.box('CATEGORY: ${_fakeProduct.category}'));
      verify(_fakeBox.values);
    });
  });
}
