import 'package:poshop/categories/models/Category.dart';
import 'package:poshop/checkout/models/ItemSimple.dart';
import 'package:poshop/checkout/models/Payment.dart';
import 'package:poshop/checkout/models/PaymentSimple.dart';
import 'package:poshop/home/model/TaxCart.dart';

class Ticket{
  int _id;
  int _total;
  String _email;
  String _code;
  List<PaymentSimple> _payments;
  List<TaxCart> _taxes;


  List<TaxCart> get taxes => _taxes;

  set taxes(List<TaxCart> value) {
    _taxes = value;
  }

  List<ItemSimple> _items;
  String _date;

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get total => _total;

  set total(int value) {
    _total = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get code => _code;

  set code(String value) {
    _code = value;
  }

  List<PaymentSimple> get payments => _payments;

  set payments(List<PaymentSimple> value) {
    _payments = value;
  }


  @override
  String toString() {
    return 'Ticket{_id: $_id, _total: $_total, _email: $_email, _code: $_code, _payments: $_payments, _taxes: $_taxes, _items: $_items, _date: $_date}';
  }

  List<ItemSimple> get items => _items;

  set items(List<ItemSimple> value) {
    _items = value;
  }
}