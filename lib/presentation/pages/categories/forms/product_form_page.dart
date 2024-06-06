import 'dart:io';

import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/infra/constants/categories_mapper.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:enxolist/infra/utils/approuter.dart';
import 'package:enxolist/infra/utils/currency_mask.dart';
import 'package:enxolist/infra/utils/image_input.dart';
import 'package:enxolist/presentation/pages/categories/controller/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProductFormPage extends StatefulWidget {
  final ProductEntity? product;
  const ProductFormPage({this.product, super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  bool isBuilding = false;
  int? _dropDownBuildValue = 5;
  final _scaffoldkey = GlobalKey<ScaffoldMessengerState>();
  final CategoriesController controller = getIt<CategoriesController>();
  final _productFormKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _urlLinkFocus = FocusNode();
  final FocusNode _wasBoughtFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _categoryFocus = FocusNode();
  final FocusNode _buildingCategoryFocus = FocusNode();
  Map<String, dynamic> _formData = {
    "wasBought": false,
  };
  File? imageFile;
  bool isLoading = false;
  void _handleImagePick(File image) {
    imageFile = image;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.product != null) {
      _formData = widget.product!.toJson();
      _dropDownBuildValue = widget.product?.buildingCategory;
    }

    int? idCategory = ModalRoute.of(context)?.settings.arguments as int;
    setState(() {
      isBuilding = idCategory == 6;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _nameFocus.dispose();
    _categoryFocus.dispose();
    _urlLinkFocus.dispose();
    _wasBoughtFocus.dispose();
  }

  onSubmit() async {
    final isValid = _productFormKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() {
      isLoading = true;
    });
    _productFormKey.currentState?.save();
    FocusScope.of(context).unfocus();
    if (widget.product != null) {
      _formData['id'] = widget.product!.id;
    }

    try {
      int previousId = ModalRoute.of(context)?.settings.arguments as int;
      ProductModel productModel = ProductModel.fromJson(_formData);
      if (widget.product != null) {
        await controller
            .updateProduct(productModel, image: imageFile)
            .then((value) {
          if (previousId == _formData['category']) {
            Navigator.of(context).pop(productModel);
          } else {
            _showSnackBar(context);
            Navigator.of(context).pushReplacementNamed(
              AppRouter.CATEGORY_LIST,
              arguments: _formData['category'],
            );
          }
        });
      } else {
        await controller
            .createProduct(productModel, image: imageFile)
            .then((value) {
          if (previousId == _formData['category']) {
            Navigator.of(context).pop(productModel);
          } else {
            _showSnackBar(context);
            Navigator.of(context).pushReplacementNamed(
              AppRouter.CATEGORY_LIST,
              arguments: _formData['category'],
            );
          }
        });
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  _showSnackBar(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: ColorsTheme.primaryColor,
      content: Text('Você foi redirecionado para categoria selecionada.'),
      duration: Duration(seconds: 3),
    ));
  }

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ocorreu um erro.'),
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Fechar.'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    int? idCategory = ModalRoute.of(context)?.settings.arguments as int;
    int _dropDownValue = idCategory;

    void dropDownCallBack(int? selectedValue) {
      setState(() {
        _dropDownValue = selectedValue ?? 0;
        idCategory = _dropDownValue;
        if (idCategory == 6) {
          isBuilding = true;
        } else {
          isBuilding = false;
        }
      });
    }

    void dropDownSecundaryCallBack(int? selectedValue) {
      setState(() {
        _dropDownValue = selectedValue ?? 0;
      });
    }

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.product?.name ?? 'Adicionar um novo produto',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: ColorsTheme.primaryColor,
                    semanticsLabel: 'Subindo imagem...',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Carregando imagem...',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Scrollbar(
                child: Padding(
                  padding: const EdgeInsets.all(ThemeConstants.padding),
                  child: Observer(builder: (context) {
                    return Form(
                      key: _productFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Parte da casa',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onBackground,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            ),
                            child: DropdownButtonFormField(
                              // Cor do texto selecionado
                              focusNode: _categoryFocus,

                              borderRadius: BorderRadius.circular(15),
                              dropdownColor:
                                  Theme.of(context).colorScheme.outline,
                              onSaved: (category) =>
                                  _formData['category'] = category,
                              elevation: 5,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                isDense: true,
                              ),
                              items: dropdownCategories(context),
                              value: _dropDownValue,
                              onChanged: (value) => dropDownCallBack(value),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          isBuilding
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Item de reforma para qual cômodo?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      child: DropdownButtonFormField(
                                        focusNode: _buildingCategoryFocus,
                                        borderRadius: BorderRadius.circular(15),
                                        dropdownColor: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        focusColor: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        onSaved: (category) =>
                                            _formData['buildingCategory'] =
                                                category,
                                        elevation: 5,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                          ),
                                          isDense: true,
                                        ),
                                        items:
                                            dropdownBuildingCategories(context),
                                        value: _dropDownBuildValue,
                                        onChanged: (value) =>
                                            dropDownSecundaryCallBack(value),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                )
                              : Container(),
                          TextFormField(
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            decoration:
                                decorationField(false, 'Nome do produto *'),
                            initialValue: _formData['name'] ?? '',
                            focusNode: _nameFocus,
                            onSaved: (name) => _formData['name'] = name ?? '',
                            validator: (_name) {
                              final name = _name ?? '';
                              if (name.trim().isEmpty) {
                                return 'Informe um nome';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                            decoration: decorationField(
                                true, 'Valor aproximado do produto *'),
                            initialValue: _formData['price']?.toString() ?? '',
                            focusNode: _priceFocus,
                            inputFormatters: [
                              CurrencyInputFormatter(),
                            ],
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            onSaved: (price) => _formData['price'] =
                                double.tryParse(price
                                            ?.replaceAll('.', '')
                                            .replaceAll(',', '.') ??
                                        '') ??
                                    0,
                            validator: (_price) {
                              final price = _price ?? '';
                              if (price.trim().isEmpty) {
                                return 'Informe uma valor aproximado';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                            decoration:
                                decorationField(false, 'Link do produto'),
                            initialValue: _formData['urlLink'] ?? '',
                            focusNode: _urlLinkFocus,
                            validator: (link) {
                              if (link != null && link.isNotEmpty) {
                                if (!link.contains('http')) {
                                  return 'Adicione um link válido.';
                                }
                              }
                              return null;
                            },
                            onSaved: (urlLink) =>
                                _formData['urlLink'] = urlLink ?? '',
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ImagePickerForm(
                            onImagePick: _handleImagePick,
                            product: widget.product,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          wasBoughtCheck(),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE36F6F),
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: onSubmit,
                              child: Text(
                                widget.product != null
                                    ? 'Salvar'
                                    : 'Adicionar novo produto',
                                style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
    );
  }

  // DropdownButtonFormField dropdownMenuCategory() {
  //   return DropdownButtonFormField(
  //     focusNode: _buildingCategoryFocus,
  //     borderRadius: BorderRadius.circular(15),
  //     dropdownColor: Theme.of(context).colorScheme.onBackground,
  //     onSaved: (category) => _formData['buildingCategory'] = category,
  //     elevation: 5,
  //     decoration: const InputDecoration(
  //       labelText: 'Para qual parte da casa?',
  //       border: OutlineInputBorder(
  //           borderRadius: BorderRadius.all(Radius.circular(8))),
  //     ),
  //     items: dropdownCategories(context),
  //     value: _dropDownValue,
  //     onChanged: (value) => dropDownCallBack(value),
  //   );
  // }

  InputDecoration decorationField(bool prefix, String labelText) {
    return InputDecoration(
      prefixText: prefix ? 'R\$ ' : null,
      prefixStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
      fillColor: Theme.of(context).colorScheme.onBackground,
      filled: true,
      enabledBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.transparent, width: 5),
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        fontFamily: "Roboto",
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 17,
      ),
    );
  }

  Widget wasBoughtCheck() {
    return SwitchListTile(
      hoverColor: Colors.transparent,
      focusNode: _wasBoughtFocus,
      title: Text(
        'Este item já foi comprado?',
        style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
      ),
      value: _formData['wasBought'] ?? false,
      onChanged: (bool? value) {
        if (value != null) {
          setState(() {
            _formData['wasBought'] = value;
          });
        }
      },
    );
  }
}
