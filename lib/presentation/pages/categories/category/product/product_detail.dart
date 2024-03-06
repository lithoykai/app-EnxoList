import 'package:cached_network_image/cached_network_image.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/infra/constants/constants_images.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/presentation/pages/categories/controller/categories_controller.dart';
import 'package:enxolist/presentation/pages/categories/forms/product_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetail extends StatefulWidget {
  ProductEntity product;
  ProductDetail({required this.product, super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final currencyFormatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  bool isLoading = false;
  final controller = getIt<CategoriesController>();

  @override
  Widget build(BuildContext context) {
    // ProductEntity product =
    //     ModalRoute.of(context)!.settings.arguments as ProductEntity;
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
                      imageUrl: (widget.product.image != null &&
                              widget.product.image!.isNotEmpty)
                          ? widget.product.image!
                          : ConstantsImage.withoutPhoto,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width * 0.5,
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
                  imageUrl: (widget.product.image != null &&
                          widget.product.image!.isNotEmpty)
                      ? widget.product.image!
                      : ConstantsImage.withoutPhoto,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.50,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                  placeholder: (context, url) => const SizedBox(
                      height: 410,
                      child: Center(child: CircularProgressIndicator())),
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
                                widget.product.name,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                // textAlign: TextAlign.start,
                              ),
                              Text(
                                'Valor médio: ${currencyFormatter.format(widget.product.price)}',
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Transform.scale(
                                    scale: 1.8,
                                    child: Observer(builder: (context) {
                                      return Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: ColorsTheme.primaryColor,
                                          value: widget.product.wasBought,
                                          onChanged: (value) async {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            await controller
                                                .toggleWasBought(widget.product)
                                                .then((value) => controller
                                                        .listByCategory(widget
                                                            .product.category)
                                                        .then((value) {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    }));

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
                      children: [
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.20,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ColorsTheme.editButtonColorBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () async {
                              final result = Navigator.of(context)
                                  .push(MaterialPageRoute(
                                builder: (context) => ProductFormPage(
                                  product: widget.product,
                                ),
                                settings: RouteSettings(
                                  arguments: widget.product.category,
                                ),
                              ))
                                  .then((value) async {
                                await controller
                                    .listByCategory(widget.product.category);
                                if (value != null) {
                                  value as ProductEntity;
                                  setState(() {
                                    widget.product = value;
                                  });
                                }
                              });
                            },
                            child: const Center(
                              child: Icon(
                                Icons.edit,
                                color: ColorsTheme.textColor,
                                size: 33,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.70,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsTheme.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: widget.product.urlLink == ''
                                  ? null
                                  : () => launchUrl(
                                      Uri.parse(widget.product.urlLink!),
                                      mode: LaunchMode.externalApplication),
                              child: const Text(
                                'Acessar link do produto.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              )),
                        ),
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
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
        ],
      ),
    );
  }
}
