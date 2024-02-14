import 'dart:io';

import 'package:enxolist/data/models/product/product_model.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/infra/constants/categories_mapper.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
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
  final CategoriesController controller = getIt<CategoriesController>();
  final _productFormKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _urlLinkFocus = FocusNode();
  final FocusNode _wasBoughtFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _categoryFocus = FocusNode();
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
    }
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
    setState(() {
      isLoading = true;
    });
    final isValid = _productFormKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    _productFormKey.currentState?.save();
    FocusScope.of(context).unfocus();
    if (widget.product != null) {
      _formData['id'] = widget.product!.id;
    }

    ProductModel productModel = ProductModel.fromJson(_formData);
    try {
      if (widget.product != null) {
        await controller
            .updateProduct(productModel, image: imageFile)
            .then((value) => Navigator.pop(context, productModel.toEntity()));
      } else {
        await controller
            .createProduct(productModel, image: imageFile)
            .then((value) => Navigator.pop(context, productModel.toEntity()));
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    }
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
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product?.name ?? 'Adicionar um novo produto'),
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
              child: Padding(
                padding: const EdgeInsets.all(ThemeConstants.padding),
                child: Observer(builder: (context) {
                  return Form(
                    key: _productFormKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: ColorsTheme.backgroundForm,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: DropdownButtonFormField(
                            focusNode: _categoryFocus,
                            borderRadius: BorderRadius.circular(15),
                            dropdownColor: ColorsTheme.backgroundForm,
                            onSaved: (category) =>
                                _formData['category'] = category,
                            elevation: 5,
                            decoration: const InputDecoration(
                              labelText: 'Parte da casa',
                              fillColor: ColorsTheme.backgroundForm,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                            items: dropdownCategories,
                            value: _dropDownValue,
                            onChanged: (value) => dropDownCallBack(value),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: decorationField('Nome do produto *'),
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
                          decoration:
                              decorationField('Valor aproximado do produto *'),
                          initialValue: _formData['price']?.toString() ?? '',
                          focusNode: _priceFocus,
                          keyboardType: const TextInputType.numberWithOptions(),
                          onSaved: (price) => _formData['price'] =
                              double.tryParse(price ?? '') ?? 0,
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
                          decoration: decorationField('Link do produto'),
                          initialValue: _formData['urlLink'] ?? '',
                          focusNode: _urlLinkFocus,
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
    );
  }

  InputDecoration decorationField(String labelText) {
    return InputDecoration(
      fillColor: ColorsTheme.backgroundForm,
      filled: true,
      enabledBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.transparent, width: 5),
      ),
      labelText: labelText,
      labelStyle: const TextStyle(
        fontFamily: "Roboto",
        color: ColorsTheme.textColorFormField,
        fontSize: 17,
      ),
    );
  }

  Widget wasBoughtCheck() {
    return SwitchListTile(
      hoverColor: Colors.transparent,
      focusNode: _wasBoughtFocus,
      title: const Text('Este item já foi comprado?'),
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
