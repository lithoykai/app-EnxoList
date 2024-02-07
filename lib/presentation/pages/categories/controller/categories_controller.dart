import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/use-cases/product/get_products.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'categories_controller.g.dart';

@singleton
class CategoriesController = _CategoriesControllerBase
    with _$CategoriesController;

abstract class _CategoriesControllerBase with Store {
  final GetProductsUseCase _getProductsUseCase;

  _CategoriesControllerBase({required GetProductsUseCase getProductsUseCase})
      : _getProductsUseCase = getProductsUseCase;

  @observable
  List<ProductEntity> products = ObservableList.of([]);

  void setProducts(List<ProductEntity> list) {
    products = ObservableList.of(list);
  }

  @action
  Future<void> listByCategory(int categoryId) async {
    final _response = await _getProductsUseCase.callCategory(categoryId);
    _response.fold((l) {
      l as ServerFailure;
      print(l.msg);
    }, (r) => setProducts(r.data));
  }
}
