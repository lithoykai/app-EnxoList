import 'package:dartz/dartz.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/repositories/product_repository.dart';
import 'package:enxolist/domain/use-cases/product/create_product.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/product_fixture.dart';
import 'get_product_test.mocks.dart';

@GenerateMocks([IProductRepository])
void main() {
  late IProductRepository repository;
  late CreateProductUseCase useCase;

  setUp(() {
    repository = MockIProductRepository();
    useCase = CreateProductUseCase(repository: repository);
  });

  group('create product use case', () {
    test('Should try create a product then return a right ProductEntity',
        () async {
      final _fixture = fakeProductModel;
      final _fakeProductEntity = fakeProduct;
      when(repository.createProduct(_fixture))
          .thenAnswer((_) async => Right(_fakeProductEntity));

      final _response = await useCase.call(_fixture);
      final _result = _response.fold((l) => l, (r) => r);

      expect(_result, isA<ProductEntity>());
    });

    test('When try get list products then either left ServerFailure', () async {
      final _fixture = fakeProductModel;
      when(repository.createProduct(_fixture))
          .thenAnswer((_) async => Left(ServerFailure()));

      final _response = await useCase.call(_fixture);
      final _result = _response.fold((l) => l, (r) => r);

      expect(_result, isA<ServerFailure>());
    });
  });
}
