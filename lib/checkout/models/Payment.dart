class Payment{
  int _id;
  String _name;
  double _price;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }


  double get price => _price;

  set price(double value) {
    _price = value;
  }

  @override
  String toString() {
    return 'Payment{_id: $_id, _name: $_name, _price: $_price}';
  }

  Payment(this._id, this._name, this._price);
}