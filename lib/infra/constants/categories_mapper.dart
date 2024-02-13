import 'package:flutter/material.dart';

class Category {
  int id;
  String title;
  Widget icon;

  Category({required this.id, required this.title, required this.icon});
}

const List<DropdownMenuItem<dynamic>>? dropdownCategories = [
  DropdownMenuItem(value: 0, child: Text('Cozinha')),
  DropdownMenuItem(value: 1, child: Text('Sala')),
  DropdownMenuItem(value: 2, child: Text('Quartos')),
  DropdownMenuItem(value: 3, child: Text('Banheiros')),
  DropdownMenuItem(value: 4, child: Text('Lavanderia')),
  DropdownMenuItem(value: 5, child: Text('Eletrodomésticos')),
  DropdownMenuItem(value: 6, child: Text('Construção/Reformas')),
  DropdownMenuItem(value: 7, child: Text('Móveis')),
];

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
