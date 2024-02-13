import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/presentation/pages/categories/category/product/product_card.dart';
import 'package:enxolist/presentation/pages/categories/controller/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CategoryListView extends StatelessWidget {
  final CategoriesController controller;

  const CategoryListView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return ListView.builder(
          itemCount: controller.filteredProducts.length,
          itemBuilder: (context, index) {
            ProductEntity product = controller.filteredProducts[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ProductCard(
                product: product,
                controller: controller,
              ),
            );
          },
        );
      },
    );
  }
}
