import 'package:poshop/checkout/models/DiscountSimple.dart';

class ItemSimple{
   String _name;
  double _quantity;
  int _ammout;

   double get quantity => _quantity;

  set quantity(double value) {
    _quantity = value;
  }

  List<DiscountSimple> _discounts;


   List<DiscountSimple> get discounts => _discounts;

  set discounts(List<DiscountSimple> value) {
    _discounts = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }


   int get ammout => _ammout;

  set ammout(int value) {
    _ammout = value;
  }



   ItemSimple(this._name, this._quantity, this._ammout, this._discounts);
}