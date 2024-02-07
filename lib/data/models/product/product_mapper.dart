import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';

ProductModel $ProductModelFromEntity(ProductEntity entity) {
  return ProductModel(
    name: entity.name,
    wasBought: entity.wasBought,
    price: entity.price,
    category: entity.category,
    id: entity.id,
    image: entity.image,
    urlLink: entity.urlLink,
  );
}

ProductEntity $ProductEntityFromModel(ProductModel model) {
  return ProductEntity(
    name: model.name,
    wasBought: model.wasBought,
    price: model.price,
    category: model.category,
    id: model.id,
    image: model.image,
    urlLink: model.urlLink,
  );
}
