import 'package:enxolist/data/data_source/clients/http_client.dart';
import 'package:enxolist/data/data_source/cost_values_remote_datasource.dart';
import 'package:enxolist/data/models/product/cost_values_model.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CostValuesDataSource)
class CostValuesDataSourceImpl implements CostValuesDataSource {
  HttpClientApp _http;

  CostValuesDataSourceImpl({required HttpClientApp httpClient})
      : _http = httpClient;

  @override
  Future<List<CostValuesModel>> getItensPercentage() async {
    try {
      final response = await _http.getMethod(Endpoints.prices);

      final data = (response.data as List)
          .map((json) => CostValuesModel.fromJson(json))
          .toList();

      return data;
    } catch (e) {
      rethrow;
    }
  }
}
