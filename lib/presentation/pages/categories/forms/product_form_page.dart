import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/infra/constants/categories_mapper.dart';
import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:enxolist/infra/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  final ProductEntity? product;
  const ProductFormPage({this.product, super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _productFormKey = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _urlLinkFocus = FocusNode();
  final FocusNode _wasBoughtFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _categoryFocus = FocusNode();
  Map<String, dynamic> _formData = {};

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

  @override
  Widget build(BuildContext context) {
    int? idCategory = ModalRoute.of(context)?.settings.arguments as int;
    int _dropDownValue = idCategory;

    void dropDownCallBack(int? selectedValue) {
      setState(() {
        _dropDownValue = selectedValue ?? 0;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product?.name ?? 'Adicionar um novo produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(ThemeConstants.padding),
        child: Form(
          key: _productFormKey,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: ColorsTheme.backgroundForm,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                // color: ColorsTheme.backgroundForm,
                child: DropdownButtonFormField(
                  focusNode: _categoryFocus,
                  borderRadius: BorderRadius.circular(15),
                  dropdownColor: ColorsTheme.backgroundForm,
                  onSaved: (category) => _formData['category'] = category,
                  elevation: 5,
                  decoration: const InputDecoration(
                    labelText: 'Parte da casa',
                    fillColor: ColorsTheme.backgroundForm,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  items: dropdownCategories,
                  value: _dropDownValue,
                  onChanged: (value) => dropDownCallBack(value),
                ),
              ),
              const SizedBox(
                height: 10,
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
                height: 10,
              ),
              TextFormField(
                decoration: decorationField('Valor aproximado do produto *'),
                initialValue: _formData['price']?.toString() ?? '',
                focusNode: _priceFocus,
                keyboardType: const TextInputType.numberWithOptions(),
                onSaved: (price) =>
                    _formData['price'] = double.tryParse(price ?? '') ?? 0,
                validator: (_price) {
                  final price = _price ?? '';
                  if (price.trim().isEmpty) {
                    return 'Informe uma valor aproximado';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: decorationField('Link do produto'),
                initialValue: _formData['urlLink']?.toString() ?? '',
                focusNode: _urlLinkFocus,
                onSaved: (urlLink) =>
                    _formData['urlLink'] = double.tryParse(urlLink ?? '') ?? 0,
              ),
              const SizedBox(
                height: 10,
              ),
              wasBoughtCheck(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
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
