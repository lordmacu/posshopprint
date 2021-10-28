class Payment{
  int _id;
  String _name;
  double _price;
  String _type;
  double _balance;
  double _totalPaid;


  double get totalPaid => _totalPaid;

  set totalPaid(double value) {
    _totalPaid = value;
  }

  double get balance => _balance;

  set balance(double value) {
    _balance = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

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

  Payment(this._id, this._name, this._price, this._type, this._balance,
      this._totalPaid);

  @override
  String toString() {
    return 'Payment{_id: $_id, _name: $_name, _price: $_price, _type: $_type, _balance: $_balance, _totalPaid: $_totalPaid}';
  }
}