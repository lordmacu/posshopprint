import 'package:poshop/categories/models/Category.dart';

class TaxCart{
   int _id;
   String _rate;

   String _name;

   String _total_tax;
   String _type;

   int get id => _id;

  set id(int value) {
    _id = value;
  }


   String get type => _type;

  set type(String value) {
    _type = value;
  }


   TaxCart(this._id, this._rate, this._name, this._total_tax, this._type);

  @override
  String toString() {
    return 'TaxCart{_id: $_id, _rate: $_rate, _name: $_name, _total_tax: $_total_tax}';
  }

   String get total_tax => _total_tax;

  set total_tax(String value) {
    _total_tax = value;
  }

  String get rate => _rate;

  set rate(String value) {
    _rate = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }


}