import 'package:poshop/categories/models/Category.dart';

class Tax{

  int _id;
  int _idOrg;
  String _type;
  String _name;
  int _rate;
  int _allowedForAllOutlets;
  int _applyForAllNewWares;
  int _applyToAllWares;


  @override
  String toString() {
    return 'Tax{_id: $_id, _idOrg: $_idOrg, _type: $_type, _name: $_name, _rate: $_rate, _allowedForAllOutlets: $_allowedForAllOutlets, _applyForAllNewWares: $_applyForAllNewWares, _applyToAllWares: $_applyToAllWares}';
  }

  Tax(
      this._id,
      this._idOrg,
      this._type,
      this._name,
      this._rate,
      this._allowedForAllOutlets,
      this._applyForAllNewWares,
      this._applyToAllWares);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get idOrg => _idOrg;

  set idOrg(int value) {
    _idOrg = value;
  }

  int get applyToAllWares => _applyToAllWares;

  set applyToAllWares(int value) {
    _applyToAllWares = value;
  }

  int get applyForAllNewWares => _applyForAllNewWares;

  set applyForAllNewWares(int value) {
    _applyForAllNewWares = value;
  }

  int get allowedForAllOutlets => _allowedForAllOutlets;

  set allowedForAllOutlets(int value) {
    _allowedForAllOutlets = value;
  }

  int get rate => _rate;

  set rate(int value) {
    _rate = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }
}