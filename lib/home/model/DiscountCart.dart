import 'package:poshop/categories/models/Category.dart';

class DiscountCart{
   int _discount_Id;
   String _total_discount;

   int get discount_Id => _discount_Id;

  set discount_Id(int value) {
    _discount_Id = value;
  }

   String get total_discount => _total_discount;

  set total_discount(String value) {
    _total_discount = value;
  }

   @override
  String toString() {
    return 'DiscountCart{_discount_Id: $_discount_Id, _total_discount: $_total_discount}';
  }

   DiscountCart(this._discount_Id, this._total_discount);
}