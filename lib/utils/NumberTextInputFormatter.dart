import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  NumberTextInputFormatter({double? maxValue})
      {
    _exp = new RegExp("^([0-9]*){0,1}\$");

    _maxValue = maxValue;
     _format = NumberFormat.currency(locale: "es_CL", symbol: '', decimalDigits: 0);
  }

  late RegExp _exp;
  late double? _maxValue;
  late NumberFormat _format;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String removeDot = newValue.text.replaceAll(".", "");
    if (_exp.hasMatch(removeDot)) {
      if (newValue.text.isNotEmpty && _maxValue != null && int.parse(removeDot) > _maxValue!) {
        return TextEditingValue(text: _format.format(_maxValue!).trim());
      } else if (newValue.text.isEmpty) {
        return newValue;
      }else {
        return TextEditingValue(text: _format.format(int.parse(removeDot)).trim());
      }
    }
    return oldValue;
  }
}
