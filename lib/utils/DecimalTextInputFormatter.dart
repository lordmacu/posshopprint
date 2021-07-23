import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'dart:math' as math;

import 'package:intl/intl.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  // final int? decimalRange;
  //
  // DecimalTextInputFormatter({this.decimalRange}) : assert(decimalRange == null || decimalRange > 0);
  //
  // @override
  // TextEditingValue formatEditUpdate(
  //   TextEditingValue oldValue, // unused.
  //   TextEditingValue newValue,
  // ) {
  //   TextSelection newSelection = newValue.selection;
  //   String truncated = newValue.text;
  //
  //   if (decimalRange != null) {
  //     String value = newValue.text;
  //
  //     if (value.contains(".") && value.substring(value.indexOf(".") + 1).length > decimalRange!) {
  //       truncated = oldValue.text;
  //       newSelection = oldValue.selection;
  //     } else if (value == ".") {
  //       truncated = "0.";
  //
  //       newSelection = newValue.selection.copyWith(
  //         baseOffset: math.min(truncated.length, truncated.length + 1),
  //         extentOffset: math.min(truncated.length, truncated.length + 1),
  //       );
  //     }
  //
  //     return TextEditingValue(
  //       text: truncated,
  //       selection: newSelection,
  //       composing: TextRange.empty,
  //     );
  //   }
  //   return newValue;
  // }
  // final int? decimalRange;
  // final bool? activatedNegativeValues;

  DecimalTextInputFormatter({int? decimalRange, bool? activatedNegativeValues, double? maxValue})
      : assert(decimalRange == null || decimalRange >= 0, 'DecimalTextInputFormatter declaration error') {
    activatedNegativeValues ??= false;
    String dp = (decimalRange != null && decimalRange > 0) ? "([,.][0-9]{0,$decimalRange}){0,1}" : "";
    String num = "[0-9]*$dp";

    if (activatedNegativeValues) {
      _exp = new RegExp("^((((-){0,1})|((-){0,1}[0-9]$num))){0,1}\$");
    } else {
      _exp = new RegExp("^($num){0,1}\$");
    }
    _maxValue = maxValue;
    _format = NumberFormat.currency(locale: "es_CL", symbol: '', decimalDigits: (decimalRange != null) ? decimalRange : 0);
  }

  late RegExp _exp;
  late double? _maxValue;
  late NumberFormat _format;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    debugPrint('1.1');
    if (_exp.hasMatch(newValue.text)) {
      debugPrint('1.2');
      if (newValue.text.isNotEmpty && _maxValue != null && double.parse(newValue.text) > _maxValue!) {
        debugPrint('1.3');
        return TextEditingValue(text: _format.format(_maxValue).trim());
      } else {
        debugPrint(newValue.text);
        // debugPrint(_format.format(double.parse(newValue.text)).trim());
        // return TextEditingValue(composing: newValue.composing, selection: newValue.selection, text: _format.format(double.parse(newValue.text)).trim());
        return newValue;
      }
    }
    return oldValue;
  }
}
