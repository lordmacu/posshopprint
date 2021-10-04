
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';

class MoneyTextInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {


    double value = double.parse(newValue.text);
    var formatter;
    String newText;
    formatter = NumberFormat.currency(
        customPattern: "\u00A4#,##0.00",
        symbol: "\$",
        decimalDigits: 0,
        locale: "es");

    newText = formatter.format(value);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
