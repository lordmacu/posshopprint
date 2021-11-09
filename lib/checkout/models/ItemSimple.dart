class ItemSimple{
   String _name;
  int _quantity;
  int _ammout;

   String get name => _name;

  set name(String value) {
    _name = value;
  }

   int get quantity => _quantity;

   int get ammout => _ammout;

  set ammout(int value) {
    _ammout = value;
  }

  set quantity(int value) {
    _quantity = value;
  }
}