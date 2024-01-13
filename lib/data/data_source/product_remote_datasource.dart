import 'package:enxolist/domain/response/product_response.dart';

abstract class IProductDataSource {
  Future<ProductResponse> getProducts();
}
