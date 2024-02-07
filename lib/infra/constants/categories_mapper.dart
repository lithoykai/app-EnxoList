import 'package:flutter/material.dart';

class Category {
  int id;
  String title;
  Widget icon;

  Category({required this.id, required this.title, required this.icon});
}

List<Category> CATEGORIES = [
  Category(
    id: 1,
    title: 'Cozinha',
    icon: const Icon(Icons.kitchen),
  ),
  Category(
    id: 2,
    title: 'Sala',
    icon: const Icon(Icons.live_tv_rounded),
  ),
  Category(
    id: 3,
    title: 'Quartos',
    icon: const Icon(Icons.bed),
  ),
  Category(
    id: 4,
    title: 'Banheiros',
    icon: const Icon(Icons.bathtub),
  ),
  Category(
    id: 5,
    title: 'Lavanderia',
    icon: const Icon(Icons.bathroom_rounded),
  ),
  Category(
    id: 6,
    title: 'Eletrodomesticos',
    icon: const Icon(Icons.microwave),
  ),
  Category(
    id: 7,
    title: 'Construção/Reformas',
    icon: const Icon(Icons.construction),
  ),
  Category(
    id: 8,
    title: 'Moveis',
    icon: const Icon(Icons.sensor_door),
  ),
];
