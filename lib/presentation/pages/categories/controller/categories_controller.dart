import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/use-cases/product/delete_product.dart';
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
  final DeleteProductUseCase _deleteProductUseCase;

  _CategoriesControllerBase(
      {required GetProductsUseCase getProductsUseCase,
      required DeleteProductUseCase deleteProductUseCase})
      : _getProductsUseCase = getProductsUseCase,
        _deleteProductUseCase = deleteProductUseCase;

  ObservableList<ProductEntity> filteredProducts =
      ObservableList<ProductEntity>();

  void searchProducts(String searchTerm) {
    if (searchTerm.isEmpty) {
      filteredProducts.clear();
      filteredProducts.addAll(products);
      filteredProducts.sort((a, b) => a.wasBought ? 1 : -1);
    } else {
      filteredProducts.clear();
      filteredProducts.addAll(products.where((product) =>
          product.name.toLowerCase().contains(searchTerm.toLowerCase())));
      filteredProducts.sort((a, b) => a.wasBought ? 1 : -1);
    }
  }

  @observable
  List<ProductEntity> products = ObservableList.of([]);

  void setProducts(List<ProductEntity> list) {
    products = ObservableList.of(list);
    products.sort((a, b) => a.wasBought ? 1 : -1);
    filteredProducts = ObservableList.of(list);
    filteredProducts.sort((a, b) => a.wasBought ? 1 : -1);
  }

  void deleteProductFromList(ProductEntity product) {
    products.remove(product);
    filteredProducts.remove(product);
  }

  @action
  Future<void> listByCategory(int categoryId) async {
    final _response = await _getProductsUseCase.callCategory(categoryId);
    _response.fold((l) {
      l as ServerFailure;
      print(l.msg);
    }, (r) => setProducts(r.data));
  }

  @action
  Future<void> deleteProduct(ProductEntity product) async {
    final _response = await _deleteProductUseCase.delete(product);
    _response.fold((l) {
      l as ServerFailure;
      throw ServerFailure(msg: l.toString());
      print(l.msg);
    }, (r) => deleteProductFromList(product));
  }
}
