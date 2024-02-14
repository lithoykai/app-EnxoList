import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/presentation/pages/categories/category/product/product_card.dart';
import 'package:enxolist/presentation/pages/categories/category/search/search_bar_delegate.dart';
import 'package:enxolist/presentation/pages/categories/category/widget/empty_list.dart';
import 'package:enxolist/presentation/pages/categories/controller/categories_controller.dart';
import 'package:enxolist/presentation/pages/categories/forms/product_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CategoryListPage extends StatefulWidget {
  // final List<ProductEntity> products;

  CategoryListPage({
    // required this.products,
    super.key,
  });

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  TextEditingController searchController =
      TextEditingController(); // Adicione este controlador

  @override
  Widget build(BuildContext context) {
    final int id = ModalRoute.of(context)!.settings.arguments as int;
    final controller = getIt<CategoriesController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBarDelegate(controller: controller),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () async => Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => const ProductFormPage(),
                    settings: RouteSettings(arguments: id),
                  ),
                )
                .then((value) async => await controller.listByCategory(id)),
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: controller.listByCategory(id),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return const Center(
                child: Text('Ocorreu um erro!'),
              );
            } else if (controller.products.isEmpty) {
              return EmptyList(
                idPage: id,
              );
            } else {
              return Observer(builder: (context) {
                if (controller.products.isEmpty) {
                  return EmptyList(
                    idPage: id,
                  );
                } else {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.filteredProducts.length,
                          itemBuilder: (context, index) {
                            ProductEntity product =
                                controller.filteredProducts[index];
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ProductCard(
                                product: product,
                                controller: controller,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              });
            }
          }),
    );
  }
}
