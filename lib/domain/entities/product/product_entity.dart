import 'package:flutter/material.dart';

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

class ProductEntity {
  final String? id;
  final String name;
  bool wasBought = false;
  final double price;
  int category;
  String? urlLink;
  String? image;
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
}
