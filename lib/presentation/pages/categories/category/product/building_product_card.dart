import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/infra/constants/categories_mapper.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/presentation/pages/categories/category/product/product_detail.dart';
import 'package:enxolist/presentation/pages/categories/controller/categories_controller.dart';
import 'package:enxolist/presentation/pages/categories/forms/product_form_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildingProductCard extends StatefulWidget {
  final ProductEntity product;
  final CategoriesController controller;
  const BuildingProductCard(
      {required this.product, required this.controller, super.key});

  @override
  State<BuildingProductCard> createState() => _BuildingProductCardState();
}

class _BuildingProductCardState extends State<BuildingProductCard> {
  final currencyFormatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProductDetail(
            product: widget.product,
          ),
        ),
      ),
      child: SizedBox(
        height: 110,
        child: Card(
          color: widget.product.wasBought
              ? ColorsTheme.primaryColor
              : ColorsTheme.greyTransparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    // color:  Colors.blue.withAlpha(150),
                    color: BUILDINGCATEGORIES
                        .firstWhere(
                          (e) => widget.product.buildingCategory == e.id,
                        )
                        .color
                        .withAlpha(widget.product.wasBought ? 100 : 150),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
                width: 15, // Largura do container azul
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Alinha os itens à esquerda
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Centraliza verticalmente
                    children: [
                      Text(
                        'Categoria: ${BUILDINGCATEGORIES.firstWhere(
                              (e) => widget.product.buildingCategory == e.id,
                            ).name}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          // Cor do texto da categoria
                          fontSize: 12, // Tamanho do texto da categoria
                        ),
                      ),
                      // Adiciona um espaçamento entre os textos
                      Text(
                        widget.product.name.length > 15
                            ? '${widget.product.name.substring(0, 15)}...'
                            : widget.product.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      Text(
                        'Valor: ${currencyFormatter.format(widget.product.price)}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ), // Adiciona um espaçamento à direita do conteúdo
              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                              backgroundColor:
                                  Theme.of(context).colorScheme.onBackground,
                              title: const Text(
                                'Deseja mesmo apagar?',
                              ),
                              content: Text(
                                  'Você tem certeza que deseja apagar este produto? ',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
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
                          },
                        );
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
            ],
          ),
        ),
      ),
    );
  }
}

   
    // return GestureDetector(
    //   onTap: () => Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) => ProductDetail(
    //         product: widget.product,
    //       ),
    //     ),
    //   ),
    //   child: SizedBox(
    //     height: 110,
    //     child: Card(
    //       color: widget.product.wasBought
    //           ? ColorsTheme.primaryColor
    //           : ColorsTheme.greyTransparent,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(10.0),
    //       ),
    //       child: Row(
    //         children: [
    //           Container(
    //             decoration: BoxDecoration(
    //                 color: Colors.blue.withAlpha(150),
    //                 borderRadius: const BorderRadius.only(
    //                     topLeft: Radius.circular(10),
    //                     bottomLeft: Radius.circular(10))),
    //             width: 15, // Largura do container azul
    //           ),
    //           Expanded(
    //             child: Padding(
    //               padding: const EdgeInsets.only(left: 15.0),
    //               child: Column(
    //                 crossAxisAlignment:
    //                     CrossAxisAlignment.start, // Alinha os itens à esquerda
    //                 mainAxisAlignment:
    //                     MainAxisAlignment.center, // Centraliza verticalmente
    //                 children: [
    //                   Text(
    //                     'Categoria: ${widget.product.category}',
    //                     style: TextStyle(
    //                       color: Theme.of(context).colorScheme.secondary,
    //                       // Cor do texto da categoria
    //                       fontSize: 12, // Tamanho do texto da categoria
    //                     ),
    //                   ),
    //                   // Adiciona um espaçamento entre os textos
    //                   Text(
    //                     widget.product.name.length > 15
    //                         ? '${widget.product.name.substring(0, 15)}...'
    //                         : widget.product.name,
    //                     style: Theme.of(context).textTheme.headlineSmall,
    //                     overflow: TextOverflow.ellipsis,
    //                     maxLines: 1,
    //                   ),

    //                   Text(
    //                     'Valor: ${currencyFormatter.format(widget.product.price)}',
    //                     style: TextStyle(
    //                       color: Theme.of(context).colorScheme.secondary,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ), // Adiciona um espaçamento à direita do conteúdo
    //           Padding(
    //             padding: const EdgeInsets.only(right: 25.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 IconButton(
    //                   onPressed: () {
    //                     setState(() {
    //                       widget.controller.toggleWasBought(widget.product);
    //                     });
    //                   },
    //                   icon: widget.product.wasBought
    //                       ? Icon(
    //                           Icons.shopping_bag,
    //                           color: widget.product.wasBought
    //                               ? ColorsTheme.background
    //                               : ColorsTheme.greyTransparent,
    //                         )
    //                       : Icon(
    //                           Icons.shopping_bag_outlined,
    //                           color: widget.product.wasBought
    //                               ? ColorsTheme.background
    //                               : ColorsTheme.textColor,
    //                         ),
    //                 ),
    //                 IconButton(
    //                   onPressed: () async {
    //                     Navigator.of(context)
    //                         .push(
    //                           MaterialPageRoute(
    //                             builder: (context) => ProductFormPage(
    //                               product: widget.product,
    //                             ),
    //                             settings: RouteSettings(
    //                                 arguments: widget.product.category),
    //                           ),
    //                         )
    //                         .then((value) async => await widget.controller
    //                             .listByCategory(widget.product.category));
    //                     // Atualize a lista de produtos
    //                   },
    //                   icon: Icon(
    //                     Icons.edit,
    //                     color: widget.product.wasBought
    //                         ? ColorsTheme.background
    //                         : ColorsTheme.textColor,
    //                   ),
    //                 ),
    //                 IconButton(
    //                   onPressed: () async {
    //                     showDialog(
    //                       context: context,
    //                       builder: (context) {
    //                         return AlertDialog(
    //                           title: const Text('Deseja mesmo apagar?'),
    //                           content: const Text(
    //                               'Você tem certeza que deseja apagar este produto? '),
    //                           actions: [
    //                             TextButton(
    //                               onPressed: () => Navigator.of(context).pop(),
    //                               child: const Text(
    //                                 'Não.',
    //                               ),
    //                             ),
    //                             TextButton(
    //                               onPressed: () async {
    //                                 await widget.controller
    //                                     .deleteProduct(widget.product)
    //                                     .then((value) =>
    //                                         Navigator.of(context).pop());
    //                               },
    //                               child: const Text(
    //                                 'Sim.',
    //                               ),
    //                             ),
    //                           ],
    //                         );
    //                       },
    //                     );
    //                   },
    //                   icon: Icon(
    //                     Icons.delete,
    //                     color: widget.product.wasBought
    //                         ? ColorsTheme.background
    //                         : ColorsTheme.textColor,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );