import 'package:dio/src/response.dart';
import 'package:enxolist/data/data_source/clients/http_clients.dart';
import 'package:enxolist/data/data_source/product_remote_datasource.dart';
import 'package:enxolist/data/models/auth/response/user_response.dart';
import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/response/product_response.dart';
import 'package:enxolist/infra/constants/endpoints.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IProductDataSource)
class ProductDataSourceImpl implements IProductDataSource {
  HttpClientApp _http;

  ProductDataSourceImpl({required HttpClientApp http}) : _http = http;

  @override
  Future<ProductResponse> getProducts() async {
    try {
      final response = await _http.getMethod(Endpoints.products);

      final data = (response.data as List)
          .map((json) => ProductModel.fromJson(json).toEntity())
          .toList();

      final result = ProductResponse(data: data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductResponse> getProductsByCategory(int categoryId) async {
    UserResponse? user;
    if (Hive.isBoxOpen('userData')) {
      var box = Hive.box('userData');
      user = box.get('userData');
    }

    try {
      final response = await _http
          .getMethod('${Endpoints.products}/${user!.id}/category/$categoryId');

      final data = (response.data as List)
          .map((json) => ProductModel.fromJson(json).toEntity())
          .toList();

      final result = ProductResponse(data: data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> deleteProduct(ProductEntity product) async {
    UserResponse? user;
    if (Hive.isBoxOpen('userData')) {
      var box = Hive.box('userData');
      user = box.get('userData');
    }

    try {
      final response =
          await _http.delete('${Endpoints.deleteProduct}/${product.id}');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> updateWasBought(ProductEntity product) async {
    Map<String, dynamic> data = {
      "wasBought": product.wasBought,
    };

    try {
      final _response =
          await _http.put('${Endpoints.products}/${product.id}', data);
      return _response;
    } catch (e) {
      rethrow;
    }
  }
}
