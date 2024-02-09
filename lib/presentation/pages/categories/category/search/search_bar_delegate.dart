import 'package:enxolist/presentation/pages/categories/category/search/category_search_view.dart';
import 'package:enxolist/presentation/pages/categories/controller/categories_controller.dart';
import 'package:flutter/material.dart';

class SearchBarDelegate extends SearchDelegate {
  final CategoriesController controller;

  SearchBarDelegate({
    required this.controller,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        query = '';
        controller.searchProducts(query);
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    controller.searchProducts(query);
    return CategoryListView(controller: controller);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: controller.products.length,
      itemBuilder: (context, index) {
        final product = controller.products[index];
        if (product.name.toLowerCase().contains(query.toLowerCase())) {
          return ListTile(
            title: Text(product.name),
            onTap: () {
              close(context, product);
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
