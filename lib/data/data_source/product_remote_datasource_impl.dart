import 'package:enxolist/data/data_source/clients/http_clients.dart';
import 'package:enxolist/data/data_source/product_remote_datasource.dart';
import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IProductDataSource)
class ProductDataSourceImpl implements IProductDataSource {
  HttpClientApp _http;

  ProductDataSourceImpl({required HttpClientApp http}) : _http = http;

  @override
  Future<ProductResponse> getProducts() async {
    try {
      final response = await _http.getMethod(Endpoints.getProducts);

      final data = (response.data as List)
          .map((json) => ProductModel.fromJson(json).toEntity())
          .toList();

      final result = ProductResponse(data: data);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
