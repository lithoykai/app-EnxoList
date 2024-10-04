import 'package:dartz/dartz.dart';
import 'package:enxolist/domain/repositories/product_repository.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/domain/use-cases/product/get_products.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/product_fixture.dart';
import 'get_product_test.mocks.dart';

@GenerateMocks([IProductRepository])
void main() {
  late IProductRepository repository;
  late GetProductsUseCase useCase;

  setUp(() {
    repository = MockIProductRepository();
    useCase = GetProductsUseCase(repository: repository);
  });

  test('When try get list products then return a right ProductResponse',
      () async {
    final _fixture = responseProduct;

    when(repository.getProducts())
        .thenAnswer((_) async => Right(responseProduct));

    final _response = await useCase.call();
    final _result = _response.fold((l) => l, (r) => r);

    expect(_result, isA<ProductResponse>());
  });

  test('When try get list products then either left ServerFailure', () async {
    when(repository.getProducts())
        .thenAnswer((_) async => Left(ServerFailure()));

    final _response = await useCase.call();
    final _result = _response.fold((l) => l, (r) => r);

    expect(_result, isA<ServerFailure>());
  });
}
