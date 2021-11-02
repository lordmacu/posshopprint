import 'package:poshop/categories/models/Category.dart';
import 'package:poshop/checkout/models/Payment.dart';

class Ticket{
  int _id;
  int _total;
  String _email;
  String _code;
  List<Payment> _payments;
  List _items;

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

  List<Payment> get payments => _payments;

  set payments(List<Payment> value) {
    _payments = value;
  }

  List get items => _items;

  set items(List value) {
    _items = value;
  }

  Ticket(this._id, this._total, this._email, this._code, this._payments,
      this._items);
}