import 'package:enxolist/data/models/product/cost_values_model.dart';

abstract class CostValuesDataSource {
  Future<List<CostValuesModel>> getItensPercentage();
}
