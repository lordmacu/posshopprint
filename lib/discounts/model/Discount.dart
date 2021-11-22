import 'package:poshop/categories/models/Category.dart';
import 'package:poshop/checkout/models/ItemSimple.dart';
import 'package:poshop/checkout/models/Payment.dart';
import 'package:poshop/checkout/models/PaymentSimple.dart';

class Discount{
  int _id;
  int _idOrg;
  String _name;
  String _calculationType;
  String _type;
  String _value;
  int _limitedAccess;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get idOrg => _idOrg;

  set idOrg(int value) {
    _idOrg = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get calculationType => _calculationType;

  set calculationType(String value) {
    _calculationType = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get value => _value;

  set value(String value) {
    _value = value;
  }


  int get limitedAccess => _limitedAccess;

  set limitedAccess(int value) {
    _limitedAccess = value;
  }

  @override
  String toString() {
    return 'Discount{_id: $_id, _idOrg: $_idOrg, _name: $_name, _calculationType: $_calculationType, _type: $_type, _value: $_value, _limitedAccess: $_limitedAccess}';
  }

}