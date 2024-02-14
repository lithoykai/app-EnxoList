import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/infra/utils/approuter.dart';
import 'package:enxolist/presentation/pages/categories/controller/categories_controller.dart';
import 'package:enxolist/presentation/pages/categories/forms/product_form_page.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final ProductEntity product;
  final CategoriesController controller;
  const ProductCard(
      {required this.product, required this.controller, super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(AppRouter.PRODUCT_DETAIL, arguments: widget.product),
      child: SizedBox(
        height: 110,
        child: Card(
          color: widget.product.wasBought
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
                  widget.product.name.length > 15
                      ? '${widget.product.name.substring(0, 15)}...'
                      : widget.product.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                subtitle: Text(
                  'Valor: R\$: ${widget.product.price.toStringAsFixed(2)}',
                ),
                trailing: Wrap(
                  spacing: 0,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.controller.toggleWasBought(widget.product);
                        });
                      },
                      icon: widget.product.wasBought
                          ? Icon(
                              Icons.shopping_bag,
                              color: widget.product.wasBought
                                  ? ColorsTheme.background
                                  : ColorsTheme.greyTransparent,
                            )
                          : Icon(
                              Icons.shopping_bag_outlined,
                              color: widget.product.wasBought
                                  ? ColorsTheme.background
                                  : ColorsTheme.textColor,
                            ),
                    ),
                    IconButton(
                      onPressed: () async {
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => ProductFormPage(
                                  product: widget.product,
                                ),
                                settings: RouteSettings(
                                    arguments: widget.product.category),
                              ),
                            )
                            .then((value) async => await widget.controller
                                .listByCategory(widget.product.category));
                        // Atualize a lista de produtos
                      },
                      icon: Icon(
                        Icons.edit,
                        color: widget.product.wasBought
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
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text(
                                      'Não.',
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await widget.controller
                                          .deleteProduct(widget.product)
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
                        color: widget.product.wasBought
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
      ),
    );
  }
}
