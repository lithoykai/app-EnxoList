import 'package:cached_network_image/cached_network_image.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/infra/utils/approuter.dart';
import 'package:enxolist/presentation/pages/categories/controller/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final controller = getIt<CategoriesController>();

  @override
  Widget build(BuildContext context) {
    ProductEntity product =
        ModalRoute.of(context)!.settings.arguments as ProductEntity;
    Future<void> _showImageBetter() async {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                children: <Widget>[
                  PinchZoom(
                    child: CachedNetworkImage(
                      imageUrl: product.image!,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 500,
                          width: 500,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: imageProvider,
                              // fit: BoxFit.fitHeight,
                            ),
                          ),
                        );
                      },
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                  ),
                ]);
          });
    }

    return Scaffold(
      backgroundColor: ColorsTheme.background,
      body: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _showImageBetter(),
                child: CachedNetworkImage(
                  imageUrl: product.image!,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 410,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(ThemeConstants.padding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                // textAlign: TextAlign.start,
                              ),
                              Text(
                                'Valor médio: R\$ ${product.price.toString()}',
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Transform.scale(
                              scale: 1.8,
                              child: Observer(builder: (context) {
                                return Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: ColorsTheme.primaryColor,
                                    value: product.wasBought,
                                    onChanged: (value) {
                                      setState(() {
                                        controller
                                            .toggleWasBought(product)
                                            .then((value) =>
                                                controller.listByCategory(
                                                    product.category));
                                      });
                                      // product.toggleWasBought();
                                    });
                              }),
                            ),
                            const Text('Realizado'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(AppRouter.PRODUCT_FORM_PAGE),
                          child: const Icon(Icons.edit),
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Text('Acessar link do produto.')),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 10,
                    ),
                  ],
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor:
                  Colors.transparent, //You can make this transparent
              elevation: 0.0, //No shadow
            ),
          ),
        ],
      ),
    );
  }
}
