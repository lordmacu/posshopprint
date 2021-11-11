import 'package:poshop/checkout/models/DiscountSimple.dart';

class ItemSimple{
   String _name;
  int _quantity;
  int _ammout;

  List<DiscountSimple> _discounts;


   List<DiscountSimple> get discounts => _discounts;

  set discounts(List<DiscountSimple> value) {
    _discounts = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

   int get quantity => _quantity;

   int get ammout => _ammout;

  set ammout(int value) {
    _ammout = value;
  }

  set quantity(int value) {
    _quantity = value;
  }

   ItemSimple(this._name, this._quantity, this._ammout, this._discounts);
}