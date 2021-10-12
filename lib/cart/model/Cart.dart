import 'package:poshop/categories/models/Category.dart';
import 'package:poshop/products/model/Product.dart';

class Cart{


  int _numberItem;
  Product _product;

  int get numberItem => _numberItem;

  set numberItem(int value) {
    _numberItem = value;
  }

  Product get product => _product;

  set product(Product value) {
    _product = value;
  }
}