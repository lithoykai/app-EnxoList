import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:flutter/material.dart';

class Category {
  int id;
  String title;
  Widget icon;

  Category({required this.id, required this.title, required this.icon});
}

List<DropdownMenuItem<dynamic>>? dropdownCategories(BuildContext context) {
  return [
    DropdownMenuItem(
        value: 0,
        child: Text(
          'Cozinha',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
    DropdownMenuItem(
        value: 1,
        child: Text(
          'Sala',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
    DropdownMenuItem(
        value: 2,
        child: Text(
          'Quartos',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
    DropdownMenuItem(
        value: 3,
        child: Text(
          'Banheiros',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
    DropdownMenuItem(
        value: 4,
        child: Text(
          'Lavanderia',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
    DropdownMenuItem(
        value: 5,
        child: Text(
          'Eletrodomésticos',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
    DropdownMenuItem(
        value: 6,
        child: Text(
          'Construção/Reformas',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
    DropdownMenuItem(
        value: 7,
        child: Text(
          'Móveis',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        )),
  ];
}

List<Category> CATEGORIES = [
  Category(
    id: 0,
    title: 'Cozinha',
    icon: const Icon(Icons.kitchen),
  ),
  Category(
    id: 1,
    title: 'Sala',
    icon: const Icon(Icons.live_tv_rounded),
  ),
  Category(
    id: 2,
    title: 'Quartos',
    icon: const Icon(Icons.bed),
  ),
  Category(
    id: 3,
    title: 'Banheiros',
    icon: const Icon(Icons.bathtub),
  ),
  Category(
    id: 4,
    title: 'Lavanderia',
    icon: const Icon(Icons.bathroom_rounded),
  ),
  Category(
    id: 5,
    title: 'Eletrodomésticos',
    icon: const Icon(Icons.microwave),
  ),
  Category(
    id: 6,
    title: 'Construção/Reformas',
    icon: const Icon(Icons.construction),
  ),
  Category(
    id: 7,
    title: 'Móveis',
    icon: const Icon(Icons.sensor_door),
  ),
];
List<BuildingCategory> BUILDINGCATEGORIES = [
  BuildingCategory(
    id: 0,
    name: 'Cozinha',
    color: Colors.red,
  ),
  BuildingCategory(
    id: 1,
    name: 'Sala',
    color: Colors.red,
  ),
  BuildingCategory(
    id: 2,
    name: 'Quartos',
    color: Colors.red,
  ),
  BuildingCategory(
    id: 3,
    name: 'Banheiros',
    color: Colors.red,
  ),
  BuildingCategory(
    id: 4,
    name: 'Lavanderia',
    color: Colors.red,
  ),
  BuildingCategory(
    id: 5,
    name: 'Eletrodomésticos',
    color: Colors.red,
  ),
  BuildingCategory(
    id: 6,
    name: 'Construção/Reformas',
    color: Colors.red,
  ),
];
