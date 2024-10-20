import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'product_entity.g.dart';

enum Room { cozinha, sala, quarto, banheiro, eletro, lavanderia, reforma }

class BuildingCategory {
  final int? id;
  final String name;
  final Color color;

  BuildingCategory({required this.id, required this.name, required this.color});

  factory BuildingCategory.fromJson(Map<String, dynamic> json) =>
      BuildingCategory(
          id: json['id'], name: json['name'], color: json['color']);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      "color": color,
    };
  }
}

@HiveType(typeId: 3)
class ProductEntity extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  bool wasBought = false;
  @HiveField(3)
  final double price;
  @HiveField(4)
  int category;
  @HiveField(5)
  String? urlLink;
  @HiveField(6)
  String? image;
  @HiveField(7)
  int? buildingCategory;

  ProductEntity(
      {required this.name,
      required this.wasBought,
      required this.price,
      required this.category,
      this.id,
      this.image,
      this.urlLink,
      this.buildingCategory});

  void toggleWasBought() {
    wasBought = !wasBought;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'wasBought': wasBought,
      'price': price,
      'category': category,
      'id': id,
      'image': image,
      'urlLink': urlLink,
      'buildingCategory': buildingCategory
    };
  }

  void setId(String value) {
    id = value;
  }
}
