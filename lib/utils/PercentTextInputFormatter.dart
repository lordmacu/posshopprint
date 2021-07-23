import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

class PercentTextInputFormatter extends TextInputFormatter {
  PercentTextInputFormatter({int? decimalRange, double? maxValue})
      : assert(decimalRange == null || decimalRange >= 0, 'PercentTextInputFormatter declaration error') {
    _exp = new RegExp("^([0-9]*){0,1}\$");

    _maxValue = maxValue;
    // _format = NumberFormat.currency(locale: "es_CL", symbol: '', decimalDigits: (decimalRange != null) ? decimalRange : 0);
    _format = NumberFormat.decimalPercentPattern(locale: "es_CL", decimalDigits: (decimalRange != null) ? decimalRange : 0);
  }

  late RegExp _exp;
  late double? _maxValue;
  late NumberFormat _format;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String removeDot = newValue.text.replaceAll(",", "");
    if (_exp.hasMatch(removeDot)) {
      if (newValue.text.isNotEmpty && _maxValue != null && int.parse(removeDot) / 100 > _maxValue!) {
        return TextEditingValue(text: _format.format(_maxValue! / 100).replaceAll("%", "").trim());
      } else if (newValue.text == "0,0") {
        return TextEditingValue();
      } else {
        return TextEditingValue(text: _format.format(int.parse(removeDot) / 10000).replaceAll("%", "").trim());
      }
    }
    return oldValue;
  }
}
