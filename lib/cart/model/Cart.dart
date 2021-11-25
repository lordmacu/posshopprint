import 'package:poshop/categories/models/Category.dart';
import 'package:poshop/home/model/DiscountCart.dart';
import 'package:poshop/products/model/Product.dart';

class Cart{


  int _numberItem;
  Product _product;

  int get numberItem => _numberItem;
  List<DiscountCart> _discount;


  List<DiscountCart> get discount => _discount;

  set discount(List<DiscountCart> value) {
    _discount = value;
  }

  String _comment;


  String get comment => _comment;

  set comment(String value) {
    _comment = value;
  }



  set numberItem(int value) {
    _numberItem = value;
  }

  Product get product => _product;

  set product(Product value) {
    _product = value;
  }

  @override
  String toString() {
    return 'Cart{_numberItem: $_numberItem, _product: $_product, _discount: $_discount, _comment: $_comment}';
  }
}