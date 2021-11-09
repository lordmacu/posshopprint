class PaymentSimple{
   String _name;
  double _price;
  String _method;

   String get name => _name;

  set name(String value) {
    _name = value;
  }

   double get price => _price;

   String get method => _method;

  set method(String value) {
    _method = value;
  }

  set price(double value) {
    _price = value;
  }

   @override
  String toString() {
    return 'Payment{_name: $_name, _price: $_price, _method: $_method}';
  }

   PaymentSimple(this._name, this._price, this._method);
}