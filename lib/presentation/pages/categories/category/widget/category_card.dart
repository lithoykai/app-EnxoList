import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/presentation/pages/categories/controller/categories_controller.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  ProductEntity product;
  CategoriesController controller;
  CategoryCard({required this.product, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Card(
        color: product.wasBought
            ? ColorsTheme.primaryColor
            : ColorsTheme.greyTransparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
          child: Center(
            child: ListTile(
              title: Text(
                product.name.length > 15
                    ? '${product.name.substring(0, 15)}...'
                    : product.name,
                style: Theme.of(context).textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Text(
                'Valor: R\$: ${product.price.toStringAsFixed(2)}',
              ),
              trailing: Wrap(
                spacing: 0,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: product.wasBought
                        ? Icon(
                            Icons.shopping_bag,
                            color: product.wasBought
                                ? ColorsTheme.background
                                : ColorsTheme.greyTransparent,
                          )
                        : Icon(
                            Icons.shopping_bag_outlined,
                            color: product.wasBought
                                ? ColorsTheme.background
                                : ColorsTheme.textColor,
                          ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      color: product.wasBought
                          ? ColorsTheme.background
                          : ColorsTheme.textColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Deseja mesmo apagar?'),
                              content: const Text(
                                  'Você tem certeza que deseja apagar este produto? '),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text(
                                    'Não.',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await controller
                                        .deleteProduct(product)
                                        .then((value) =>
                                            Navigator.of(context).pop());
                                  },
                                  child: const Text(
                                    'Sim.',
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: product.wasBought
                          ? ColorsTheme.background
                          : ColorsTheme.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
