import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _currencyFormat;

  CurrencyInputFormatter({String locale = 'pt_BR'})
      : _currencyFormat = NumberFormat.currency(locale: locale, symbol: '');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String newText = _format(newValue.text);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _format(String text) {
    text = text.replaceAll(RegExp(r'[^\d]'), '');

    if (text.isNotEmpty) {
      double value = double.parse(text) / 100;
      return _currencyFormat.format(value);
    } else {
      return '';
    }
  }
}
