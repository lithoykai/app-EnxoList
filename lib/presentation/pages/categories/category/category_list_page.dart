import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/infra/utils/approuter.dart';
import 'package:enxolist/presentation/pages/categories/category/widget/empty_list.dart';
import 'package:enxolist/presentation/pages/categories/controller/categories_controller.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    final int id = ModalRoute.of(context)!.settings.arguments as int;
    final controller = getIt<CategoriesController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRouter.PRODUCT_FORM_PAGE),
              icon: const Icon(Icons.add))
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
              return const EmptyList();
            } else {
              return ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    ProductEntity product = controller.products[index];
                    return ListTile(
                      title: Text(product.name),
                      trailing: Text(product.id!),
                    );
                  });
            }
          }),
    );
  }
}
