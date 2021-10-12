import 'package:poshop/categories/models/Category.dart';

class Product{
  int _id;
  int _idOrg;
  int _idDefaultSupplier;
  String _type;
  int _keepCount;
  int _divisible;
  int _freePrice;
  String _itemNme;
  int _salesPrice;
  int _primeCost;
  int _purchaseCost;
  String _article;
  String _color;
  String _shape;
  String _barCode;
  int _idUserCreated;
  int _idUserUpdate;
  int _cartNumber;

  int get cartNumber => _cartNumber;

  set cartNumber(int value) {
    _cartNumber = value;
  }

  int _categoryId;
  String _image;
  Category _category;

  int get categoryId => _categoryId;

  set categoryId(int value) {
    _categoryId = value;
  }

  Product(this._id,this._itemNme);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get idOrg => _idOrg;

  set idOrg(int value) {
    _idOrg = value;
  }

  Category get category => _category;

  @override
  String toString() {
    return 'Product{_id: $_id, _idOrg: $_idOrg, _idDefaultSupplier: $_idDefaultSupplier, _type: $_type, _keepCount: $_keepCount, _divisible: $_divisible, _freePrice: $_freePrice, _itemNme: $_itemNme, _salesPrice: $_salesPrice, _primeCost: $_primeCost, _purchaseCost: $_purchaseCost, _article: $_article, _color: $_color, _shape: $_shape, _barCode: $_barCode, _idUserCreated: $_idUserCreated, _idUserUpdate: $_idUserUpdate, _image: $_image, _category: $_category}';
  }

  set category(Category value) {
    _category = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  int get idUserUpdate => _idUserUpdate;

  set idUserUpdate(int value) {
    _idUserUpdate = value;
  }

  int get idUserCreated => _idUserCreated;

  set idUserCreated(int value) {
    _idUserCreated = value;
  }

  String get barCode => _barCode;

  set barCode(String value) {
    _barCode = value;
  }

  String get shape => _shape;

  set shape(String value) {
    _shape = value;
  }

  String get color => _color;

  set color(String value) {
    _color = value;
  }

  String get article => _article;

  set article(String value) {
    _article = value;
  }

  int get purchaseCost => _purchaseCost;

  set purchaseCost(int value) {
    _purchaseCost = value;
  }

  int get primeCost => _primeCost;

  set primeCost(int value) {
    _primeCost = value;
  }

  int get salesPrice => _salesPrice;

  set salesPrice(int value) {
    _salesPrice = value;
  }

  String get itemNme => _itemNme;

  set itemNme(String value) {
    _itemNme = value;
  }

  int get freePrice => _freePrice;

  set freePrice(int value) {
    _freePrice = value;
  }

  int get divisible => _divisible;

  set divisible(int value) {
    _divisible = value;
  }

  int get keepCount => _keepCount;

  set keepCount(int value) {
    _keepCount = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  int get idDefaultSupplier => _idDefaultSupplier;

  set idDefaultSupplier(int value) {
    _idDefaultSupplier = value;
  }
}