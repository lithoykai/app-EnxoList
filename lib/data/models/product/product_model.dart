import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'product_mapper.dart';

part 'product_model.g.dart';

enum Room { cozinha, sala, quarto, banheiro, eletro, lavanderia, reforma }

@JsonSerializable(anyMap: true, explicitToJson: true)
class ProductModel extends ProductEntity {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'wasBought')
  bool wasBought = false;

  @JsonKey(name: 'price')
  final double price;

  @JsonKey(name: 'category')
  int category;

  @JsonKey(name: 'urlLink')
  String? urlLink;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'buildingCategory')
  int? buildingCategory;

  ProductModel(
      {required this.name,
      required this.wasBought,
      required this.price,
      required this.category,
      this.id,
      this.image,
      this.urlLink,
      this.buildingCategory})
      : super(
          name: name,
          wasBought: wasBought,
          price: price,
          category: category,
          id: id,
          image: image,
          urlLink: urlLink,
          buildingCategory: buildingCategory,
        );

  void toggleWasBought() {
    wasBought = !wasBought;
  }

  factory ProductModel.fromJson(Map json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
  factory ProductModel.fromEntity(ProductEntity entity) =>
      $ProductModelFromEntity(entity);
  ProductEntity toEntity() => $ProductEntityFromModel(this);
}
