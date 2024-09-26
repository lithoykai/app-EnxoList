import 'package:dartz/dartz.dart';
import 'package:enxolist/domain/repositories/product_repository.dart';
import 'package:enxolist/domain/use-cases/product/delete_product.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/product_fixture.dart';
import 'get_product_test.mocks.dart';

@GenerateMocks([IProductRepository])
void main() {
  late IProductRepository repository;
  late DeleteProductUseCase useCase;

  setUp(() {
    repository = MockIProductRepository();
    useCase = DeleteProductUseCase(repository: repository);
  });

  test('Should delete product then return a right String msg', () async {
    final _fixture = responseProduct;
    final _fakeProduct = fakeProduct;
    when(repository.deleteProduct(_fakeProduct))
        .thenAnswer((_) async => Right('Produto deletado com sucesso'));

    final _response = await useCase.delete(fakeProduct);
    final _result = _response.fold((l) => l, (r) => r);

    expect(_result, isA<String>());
  });

  test('Should delete product then either left ServerFailure', () async {
    final _fakeProduct = fakeProduct;
    when(repository.getProducts())
        .thenAnswer((_) async => Left(ServerFailure()));

    final _response = await useCase.delete(_fakeProduct);
    final _result = _response.fold((l) => l, (r) => r);

    expect(_result, isA<ServerFailure>());
  });
}
