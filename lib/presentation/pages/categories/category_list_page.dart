import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/infra/constants/categories_mapper.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/infra/utils/approuter.dart';
import 'package:enxolist/presentation/pages/categories/category/product/product_card.dart';
import 'package:enxolist/presentation/pages/categories/category/search/search_bar_delegate.dart';
import 'package:enxolist/presentation/pages/categories/category/widget/empty_list.dart';
import 'package:enxolist/presentation/pages/categories/controller/categories_controller.dart';
import 'package:enxolist/presentation/pages/categories/forms/product_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

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
  final controller = getIt<CategoriesController>();
  final currencyFormatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  TextEditingController searchController =
      TextEditingController(); // Adicione este controlador

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller
        .listByCategory(ModalRoute.of(context)!.settings.arguments as int);
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          onPressed: () => Navigator.of(context)
              .pushReplacementNamed(AppRouter.AUTH_OR_HOME),
        ),
        title: Text(
          '${CATEGORIES[id].title} - Lista de produtos',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchBarDelegate(controller: controller),
              );
            },
            icon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onSecondary,
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
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.onSecondary,
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
            } else {
              return RefreshIndicator.adaptive(
                onRefresh: () async => await controller.listByCategory(id),
                child: Observer(builder: (context) {
                  if (controller.products.isEmpty) {
                    return EmptyList(
                      idPage: id,
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          color: Theme.of(context).colorScheme.surface,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: ThemeConstants.halfPadding,
                                horizontal: ThemeConstants.padding),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Valor total:',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                    ),
                                    Observer(builder: (context) {
                                      return Text(
                                        currencyFormatter.format(controller
                                            .totalValueForCategory(id)),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      );
                                    })
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Valor comprado:',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                    ),
                                    Observer(builder: (context) {
                                      return Text(
                                        currencyFormatter.format(controller
                                            .totalValueBoughtForCategory(id)),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      );
                                    })
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Observer(builder: (context) {
                            return ListView.builder(
                              itemCount: controller.filteredProducts.length,
                              itemBuilder: (context, index) {
                                ProductEntity product =
                                    controller.filteredProducts[index];
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ProductCard(
                                    product: product,
                                    controller: controller,
                                  ),
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    );
                  }
                }),
              );
            }
          }),
    );
  }
}
