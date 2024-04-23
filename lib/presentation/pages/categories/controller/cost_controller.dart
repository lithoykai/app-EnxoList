import 'package:enxolist/data/models/product/cost_values_model.dart';
import 'package:enxolist/domain/use-cases/finances/get_percentage.dart';
import 'package:enxolist/infra/failure/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'cost_controller.g.dart';

@singleton
class CostController = _CostControllerBase with _$CostController;

abstract class _CostControllerBase with Store {
  final GetPercetangeUseCase _getPercetangeUseCase;

  _CostControllerBase({
    required GetPercetangeUseCase getPercetangeUseCase,
  }) : _getPercetangeUseCase = getPercetangeUseCase;

  List<CostValuesModel> cost = ObservableList.of([]);

  @action
  void setValues(List<CostValuesModel> list) {
    cost = ObservableList.of(list);
  }

  @action
  Future<void> list() async {
    final _response = await _getPercetangeUseCase.call();
    _response.fold((l) {
      l as ServerFailure;
      throw ServerFailure();
    }, (r) => setValues(r));
  }

  double calculateCategoryPercentage(int categoryId) {
    list();
    List<CostValuesModel> categoryCosts =
        cost.where((item) => item.category == categoryId).toList();

    double totalCost =
        categoryCosts.fold(0, (total, item) => total + item.totalPrice);
    double totalBoughtCost = categoryCosts.fold(
        0, (total, item) => total + item.totalPriceWasBought);

    return totalCost > 0
        ? ((totalBoughtCost / totalCost) * 100) * 120 / 100
        : 0;
  }
}
